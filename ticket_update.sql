USE Database1;


-- update task 1 : Increase the amount of Adult tickets for the Exeter Food Festival by 100

UPDATE Event
SET NumOfTickets = NumOfTickets + 100
WHERE EventID = 1;
-- Assuming Exeter Food Festival has EventID 1




-- update 4 -- Insert data into Vouchers table for Exmouth Music Festival
INSERT INTO Vouchers
    (Code, discountAmount, EventID)
VALUES
    ('SUMMER20', 20.00, 2);

