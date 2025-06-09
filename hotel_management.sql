-- Room types like Deluxe, Suite, etc.
CREATE TABLE RoomTypeMaster (
    RoomTypeId INT IDENTITY(1,1) PRIMARY KEY,
    RoomTypeName VARCHAR(50),
    PricePerDay DECIMAL(10, 2),
    TotalRooms INT,
    Active BIT DEFAULT 1
);

-- Customer information
CREATE TABLE CustomerMaster (
    CustomerId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Active BIT DEFAULT 1
);

-- Booking summary
CREATE TABLE BookingMaster (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    TotalAmount DECIMAL(10,2),
    BookingDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerId) REFERENCES CustomerMaster(CustomerId)
);

-- Booking details per room type
CREATE TABLE BookingDetails (
    BookingDetailId INT IDENTITY(1,1) PRIMARY KEY,
    BookingId INT,
    RoomTypeId INT,
    NumberOfRooms INT,
    FOREIGN KEY (BookingId) REFERENCES BookingMaster(BookingId),
    FOREIGN KEY (RoomTypeId) REFERENCES RoomTypeMaster(RoomTypeId)
);

CREATE TABLE PaymentMaster (
    PaymentId INT IDENTITY(1,1) PRIMARY KEY,
    BookingId INT,
    AmountPaid DECIMAL(10,2) NOT NULL,
    PaymentMode VARCHAR(20) CHECK (PaymentMode IN ('Cash', 'Card', 'UPI')),
    PaymentStatus VARCHAR(20) DEFAULT 'Paid' CHECK (PaymentStatus IN ('Paid', 'Pending', 'Refunded')),
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookingId) REFERENCES BookingMaster(BookingId)
);

-- Insert Room Type
INSERT INTO RoomTypeMaster (RoomTypeName, PricePerDay, TotalRooms)
VALUES ('Deluxe', 3000.00, 10), ('Suite', 5000.00, 5);

INSERT INTO RoomTypeMaster (RoomTypeName, PricePerDay, TotalRooms)
VALUES('Standard', 2000.00, 20);

-- Insert Customer
INSERT INTO CustomerMaster (CustomerName, Phone, Email)
VALUES ('Aastha Joshi', '9876543210', 'aastha@example.com');

INSERT INTO CustomerMaster (CustomerName, Phone, Email)
VALUES ('Rohan Mehta', '9123456789', 'rohanm@example.com'), ('Priya Shah', '9988776655', 'priyashah@example.com');

-- Assuming CustomerId 1 = Aastha Joshi
INSERT INTO BookingMaster (CustomerId, CheckInDate, CheckOutDate, TotalAmount)
VALUES 
(1, '2025-06-10', '2025-06-13', 20160.00); -- 3 nights, 2 rooms Deluxe, with 12% GST

-- BookingId = 1, RoomTypeId = 1 (Deluxe), 2 Rooms
INSERT INTO BookingDetails (BookingId, RoomTypeId, NumberOfRooms)
VALUES 
(1, 1, 2);

ALTER TABLE BookingMaster
ADD PaymentStatus VARCHAR(20) DEFAULT 'Unpaid';

SELECT * FROM RoomTypeMaster;
SELECT * FROM CustomerMaster;
SELECT * FROM BookingMaster;
SELECT * FROM BookingDetails;


ALTER FUNCTION CalculateBookingAmount (
    @PricePerDay DECIMAL(10,2),
    @NoOfRooms INT,
    @NoOfDays INT,
    @GSTPercent DECIMAL(5,2)
	
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalBeforeGST DECIMAL(10,2) = @PricePerDay * @NoOfRooms * @NoOfDays;
    DECLARE @GSTAmount DECIMAL(10,2) = (@TotalBeforeGST * @GSTPercent) / 100;
    RETURN @TotalBeforeGST + @GSTAmount;
END;


ALTER PROCEDURE InsertHotelBooking
    @CustomerId INT,
    @RoomTypeId INT,
    @NumberOfRooms INT,
    @CheckInDate DATE,
    @CheckOutDate DATE,
    @GSTPercent DECIMAL(5,2),
	@InitialPayment DECIMAL(10,2),
    @PaymentMode VARCHAR(20)
AS
BEGIN
    -- Validate check-in/check-out dates
    IF @CheckOutDate <= @CheckInDate
    BEGIN
        RAISERROR('Check-out date must be after check-in date.', 16, 1);
        RETURN;
    END

    -- Validate customer
    IF NOT EXISTS (
        SELECT 1 
        FROM CustomerMaster 
        WHERE CustomerId = @CustomerId AND Active = 1
    )
    BEGIN
        RAISERROR('Invalid or inactive customer.', 16, 1);
        RETURN;
    END

    -- Validate room type
    DECLARE @TotalRooms INT, @PricePerDay DECIMAL(10,2);
    SELECT 
        @TotalRooms = TotalRooms,
        @PricePerDay = PricePerDay
    FROM RoomTypeMaster
    WHERE RoomTypeId = @RoomTypeId AND Active = 1;

    IF @TotalRooms IS NULL
    BEGIN
        RAISERROR('Room type does not exist or is inactive.', 16, 1);
        RETURN;
    END

    -- Create date-wise room availability tracking
    DECLARE @TempDateWise TABLE (
        BookingDate DATE,
        RoomsBooked INT,
        RoomsAvailable INT
    );

    DECLARE @CurrentDate DATE = @CheckInDate;

    WHILE @CurrentDate < @CheckOutDate
    BEGIN
        DECLARE @Booked INT;

        SELECT @Booked = ISNULL(SUM(BD.NumberOfRooms), 0)
        FROM BookingDetails BD
        INNER JOIN BookingMaster BM ON BD.BookingId = BM.BookingId
        WHERE BD.RoomTypeId = @RoomTypeId
          AND @CurrentDate >= BM.CheckInDate
          AND @CurrentDate < BM.CheckOutDate;

        INSERT INTO @TempDateWise (BookingDate, RoomsBooked, RoomsAvailable)
        VALUES (@CurrentDate, @Booked, @TotalRooms - @Booked);

        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END

    -- Check for insufficient availability
    IF EXISTS (
        SELECT 1 FROM @TempDateWise
        WHERE RoomsAvailable < @NumberOfRooms
    )
    BEGIN
        -- Count how many days are fully unavailable
        DECLARE @UnavailableDays INT = (
            SELECT COUNT(*) 
            FROM @TempDateWise 
            WHERE RoomsAvailable < @NumberOfRooms
        );

        DECLARE @TotalDays INT = DATEDIFF(DAY, @CheckInDate, @CheckOutDate);

        -- Case 1: Entire range not available
        IF @UnavailableDays = @TotalDays
        BEGIN
            RAISERROR('Rooms not available for the given date range.', 16, 1);
            RETURN;
        END
        ELSE
        BEGIN
            -- Case 2: Some days available, suggest alternative
            DECLARE @UnavailableDates VARCHAR(MAX) = '';
            SELECT @UnavailableDates = 
                STRING_AGG(CONVERT(VARCHAR(11), BookingDate, 106), ' & ')
            FROM @TempDateWise
            WHERE RoomsAvailable < @NumberOfRooms;

            DECLARE @SuggestedDate DATE;
            SELECT TOP 1 @SuggestedDate = BookingDate
            FROM @TempDateWise
            WHERE RoomsAvailable >= @NumberOfRooms
            ORDER BY BookingDate;

            DECLARE @Message NVARCHAR(400);
            SET @Message = 'Only ' 
                + CAST((SELECT MIN(RoomsAvailable) FROM @TempDateWise WHERE RoomsAvailable < @NumberOfRooms) AS VARCHAR)
                + ' rooms are available on ' + @UnavailableDates
                + '. You can book ' + CAST(@NumberOfRooms AS VARCHAR)
                + ' rooms starting from ' + FORMAT(@SuggestedDate, 'dd MMMM yyyy') + '.';

            RAISERROR(@Message, 16, 1);
            RETURN;
        END
    END

    -- Calculate number of days
    DECLARE @Days INT = DATEDIFF(DAY, @CheckInDate, @CheckOutDate);

    -- Calculate total amount using UDF
    DECLARE @TotalAmount DECIMAL(10,2);
    SELECT @TotalAmount = dbo.CalculateBookingAmount(@PricePerDay, @NumberOfRooms, @Days, @GSTPercent);

		IF @InitialPayment > @TotalAmount
	BEGIN
		RAISERROR('Initial payment cannot exceed total booking amount.', 16, 1);
		RETURN;
	END

		-- Calculate remaining amount
	DECLARE @RemainingAmount DECIMAL(10,2) = @TotalAmount - @InitialPayment;

	-- Decide PaymentStatus
	DECLARE @PaymentStatus VARCHAR(20);
	SET @PaymentStatus = 
		CASE 
			WHEN @RemainingAmount = 0 THEN 'Paid'
			ELSE 'Partially Paid'
		END;

	-- Insert into BookingMaster
	INSERT INTO BookingMaster (
		CustomerId, CheckInDate, CheckOutDate, TotalAmount, BookingStatus, PaymentStatus
	)
	VALUES (
		@CustomerId, @CheckInDate, @CheckOutDate, @TotalAmount, 'Booked', @PaymentStatus
	);

	DECLARE @NewBookingId INT = SCOPE_IDENTITY();

	-- Insert into BookingDetails
	INSERT INTO BookingDetails (BookingId, RoomTypeId, NumberOfRooms)
	VALUES (@NewBookingId, @RoomTypeId, @NumberOfRooms);

	-- Insert into PaymentMaster
	INSERT INTO PaymentMaster (BookingId, AmountPaid, RemainingAmount, PaymentMode)
	VALUES (@NewBookingId, @InitialPayment, @RemainingAmount, @PaymentMode);


    PRINT 'Booking created successfully with Booking ID = ' + CAST(@NewBookingId AS VARCHAR);
END


SELECT * FROM RoomTypeMaster;
SELECT * FROM CustomerMaster;
SELECT * FROM BookingMaster;
SELECT * FROM BookingDetails;
SELECT * FROM PaymentMaster;

EXEC InsertHotelBooking @CustomerId = 3, @CheckInDate= '2025-02-20', @CheckOutDate= '2025-02-21', @RoomTypeId= 2, @NumberOfRooms=1,  @GSTPercent = 10.0, @InitialPayment = 5500.00, 
    @PaymentMode = 'UPI';

