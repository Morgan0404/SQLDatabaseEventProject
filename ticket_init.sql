-- CREATING DATABASE
CREATE DATABASE IF NOT EXISTS Database1 ;

USE Database1;


-- CREATING TABLES

-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    fName VARCHAR(50),
    lName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20)
);

-- Create Event table
CREATE TABLE Event (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    EventName VARCHAR(100),
    Price DECIMAL(10, 2),
    NumOfTickets INT,
    EventDate DATE,
    EventStartTime TIME,
    EventEndTime TIME,
    EventDescription TEXT,
    EventVenue VARCHAR(100)
);

-- Create Vouchers table
CREATE TABLE Vouchers (
    VoucherCodeID INT PRIMARY KEY AUTO_INCREMENT,
    Code VARCHAR(50),
    discountAmount DECIMAL(5, 2),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Create EventStatus table
CREATE TABLE EventStatus (
    EventStatusID INT PRIMARY KEY AUTO_INCREMENT,
    DeliveryMethod VARCHAR(50),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Create TicketType table
CREATE TABLE TicketType (
    TypeID INT PRIMARY KEY AUTO_INCREMENT,
    TicketTypeName VARCHAR(50),
    TicketTypePrice DECIMAL(10, 2),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Create Booking table with modified VoucherCodeID
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    BookingDate DATE,
    ReferenceCode VARCHAR(50),
    CustomerID INT,
    EventID INT,
    VoucherCodeID INT NULL, -- Allow NULL values
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (VoucherCodeID) REFERENCES Vouchers(VoucherCodeID)
);

-- Create CustomerOrder table
CREATE TABLE CustomerOrder (
    CustomerOrderID INT PRIMARY KEY AUTO_INCREMENT,
    QuantityType VARCHAR(50),
    PriceOfAll DECIMAL(10, 2),
    BookingID INT,
    TypeID INT,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (TypeID) REFERENCES TicketType(TypeID)
);

-- Create Payment table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    CardType VARCHAR(50),
    CardNumber VARCHAR(20),
    SecurityCode VARCHAR(10),
    ExpiryDate DATE,
    CustomerOrderID INT,
    FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrder(CustomerOrderID)
);

-- Create TicketDelivery table
CREATE TABLE TicketDelivery (
    TicketDeliveryID INT PRIMARY KEY AUTO_INCREMENT,
    DeliveryMethod VARCHAR(50),
    BookingID INT,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

-- Create Refund table
CREATE TABLE Refund (
    RefundID INT PRIMARY KEY AUTO_INCREMENT,
    RefundAmount DECIMAL(10, 2),
    RefundReason TEXT,
    RefundDate DATE,
    BookingID INT,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

-- Create Email table
CREATE TABLE Email (
    EmailAddress VARCHAR(100) PRIMARY KEY
);

-- Create Pickup table
CREATE TABLE Pickup (
    VenueName VARCHAR(100),
    PickupLocation VARCHAR(100),
    PRIMARY KEY (VenueName, PickupLocation)
);



-- DATA INSERTION: 


-- Insert data into Customer table
INSERT INTO Customer (fName, lName, Email, PhoneNumber)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '1234567890'),
    ('Jane', 'Smith', 'jane.smith@example.com', '9876543210');

-- Insert data into Event table
INSERT INTO Event (EventName, Price, NumOfTickets, EventDate, EventStartTime, EventEndTime, EventDescription, EventVenue)
VALUES
    ('Exeter Food Festival 2023', 20.00, 500, '2023-07-01', '12:00:00', '20:00:00', 'Food festival in Exeter', 'Exeter Park'),
    ('Exmouth Music Festival 2023', 30.00, 300, '2023-07-05', '15:00:00', '23:00:00', 'Music festival in Exmouth', 'Exmouth Arena');

-- Insert data into TicketType table
INSERT INTO TicketType (TicketTypeName, TicketTypePrice, EventID)
VALUES
    ('Adult', 20.00, 1),
    ('Child', 15.00, 1),
    ('Gold', 50.00, 2),
    ('Silver', 40.00, 2),
    ('Bronze', 30.00, 2);

-- Insert data into Vouchers table
INSERT INTO Vouchers (Code, discountAmount, EventID)
VALUES
    ('SUMMER25', 25.00, 1);

-- Insert data into Booking table with NULL in VoucherCodeID
INSERT INTO Booking (BookingDate, ReferenceCode, CustomerID, EventID, VoucherCodeID)
VALUES
    ('2023-06-15', 'ABC123', 1, 1, 1),
    ('2023-06-20', 'XYZ456', 2, 2, NULL);

-- Insert data into CustomerOrder table
INSERT INTO CustomerOrder (QuantityType, PriceOfAll, BookingID, TypeID)
VALUES
    ('Adult', 20.00, 1, 1),
    ('Child', 15.00, 1, 2),
    ('Gold', 50.00, 2, 3),
    ('Silver', 40.00, 2, 4),
    ('Bronze', 30.00, 2, 5);

-- Insert data into Payment table
INSERT INTO Payment (CardType, CardNumber, SecurityCode, ExpiryDate, CustomerOrderID)
VALUES
    ('Visa', '1234567890123456', '123', '2024-12-31', 1),
    ('MasterCard', '9876543210987654', '456', '2023-10-31', 3);

-- Insert data into TicketDelivery table
INSERT INTO TicketDelivery (DeliveryMethod, BookingID)
VALUES
    ('Email', 1),
    ('Pickup', 2);

-- Insert data into Refund table
INSERT INTO Refund (RefundAmount, RefundReason, RefundDate, BookingID)
VALUES
    (10.00, 'Change of plans', '2023-07-01', 1);

-- Insert data into Email table
INSERT INTO Email (EmailAddress)
VALUES
    ('support@example.com');

-- Insert data into Pickup table
INSERT INTO Pickup (VenueName, PickupLocation)
VALUES
    ('Exeter Park', 'Main Entrance');

-- Inserting into event

INSERT INTO Event (EventName, Price, NumOfTickets, EventDate, EventStartTime, EventEndTime, EventDescription, EventVenue)
VALUES
    ('Exeter Event 1', 25.00, 200, '2023-07-02', '14:00:00', '18:00:00', 'Description for Exeter Event 1', 'Exeter'),
    ('Exeter Event 2', 30.00, 150, '2023-07-05', '16:00:00', '20:00:00', 'Description for Exeter Event 2', 'Exeter'),
    ('Exeter Event 3', 20.00, 100, '2023-07-08', '12:00:00', '16:00:00', 'Description for Exeter Event 3', 'Exeter');


-- Insert data into Booking table for Gold tickets at Exmouth Music Festival
INSERT INTO Booking (BookingDate, ReferenceCode, CustomerID, EventID)
VALUES
    ('2023-07-15', 'GOLD001', 1, 2),
    ('2023-07-18', 'GOLD002', 2, 2),
    ('2023-07-20', 'GOLD003', 1, 2);

-- Insert data into CustomerOrder table for Gold tickets
INSERT INTO CustomerOrder (QuantityType, PriceOfAll, BookingID, TypeID)
VALUES
    ('Gold', 50.00, 1, 3),
    ('Gold', 50.00, 2, 3),
    ('Gold', 50.00, 3, 3);

-- Insert data into Booking table for Exeter Food Festival
INSERT INTO Booking (BookingDate, ReferenceCode, CustomerID, EventID)
VALUES
    ('2023-06-25', 'DEF123', 2, 1),
    ('2023-06-28', 'GHI456', 1, 1);

-- Insert data into CustomerOrder table for Adult and Child tickets
INSERT INTO CustomerOrder (QuantityType, PriceOfAll, BookingID, TypeID)
VALUES
    ('Adult', 20.00, 4, 1),
    ('Child', 15.00, 4, 2),
    ('Child', 15.00, 5, 2),
    ('Adult', 20.00, 6, 1),
    ('Child', 15.00, 6, 2);

-- Insert data into Payment table for the new bookings
INSERT INTO Payment (CardType, CardNumber, SecurityCode, ExpiryDate, CustomerOrderID)
VALUES
    ('Visa', '9876543210123456', '456', '2023-09-30', 4),
    ('MasterCard', '1234567890987654', '789', '2023-08-31', 5);

-- Insert data into TicketDelivery table for the new bookings
INSERT INTO TicketDelivery (DeliveryMethod, BookingID)
VALUES
    ('Email', 4),
    ('Pickup', 5);

-- Insert data into Refund table for a refund
INSERT INTO Refund (RefundAmount, RefundReason, RefundDate, BookingID)
VALUES
    (5.00, 'Change of plans', '2023-07-02', 4);

-- Insert data into Email table
INSERT INTO Email (EmailAddress)
VALUES
    ('info@example.com');

-- Insert data into Event table for Exeter Events
INSERT INTO Event (EventName, Price, NumOfTickets, EventDate, EventStartTime, EventEndTime, EventDescription, EventVenue)
VALUES
    ('Exeter Event 4', 25.00, 120, '2023-07-12', '13:00:00', '17:00:00', 'Description for Exeter Event 4', 'Exeter'),
    ('Exeter Event 5', 35.00, 180, '2023-07-15', '15:00:00', '19:00:00', 'Description for Exeter Event 5', 'Exeter'),
    ('Exeter Event 6', 18.00, 80, '2023-07-18', '11:00:00', '15:00:00', 'Description for Exeter Event 6', 'Exeter');

-- Insert data into Booking table for Exmouth Music Festival
INSERT INTO Booking (BookingDate, ReferenceCode, CustomerID, EventID)
VALUES
    ('2023-07-25', 'GOLD004', 2, 2),
    ('2023-07-28', 'GOLD005', 1, 2);

-- Insert data into CustomerOrder table for additional Gold tickets
INSERT INTO CustomerOrder (QuantityType, PriceOfAll, BookingID, TypeID)
VALUES
    ('Gold', 50.00, 7, 3),
    ('Gold', 50.00, 8, 3);

-- Insert data into Payment table for the new bookings
INSERT INTO Payment (CardType, CardNumber, SecurityCode, ExpiryDate, CustomerOrderID)
VALUES
    ('Visa', '1111222233334444', '111', '2023-11-30', 7),
    ('MasterCard', '5555666677778888', '222', '2023-10-31', 8);

-- Insert data into TicketDelivery table for the new bookings
INSERT INTO TicketDelivery (DeliveryMethod, BookingID)
VALUES
    ('Email', 7),
    ('Pickup', 8);
