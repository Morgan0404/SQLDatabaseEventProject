
USE Database1;

-- task 1: List all relevant information about this festival, including the venue, the starting and end time, the total number of each type of tickets

SELECT
    e.EventName,
    e.EventVenue,
    e.EventDate,
    e.EventStartTime,
    e.EventEndTime,
    SUM(CASE WHEN tt.TicketTypeName = 'Adult' THEN co.QuantityType ELSE 0 END) AS AdultTickets,
    SUM(CASE WHEN tt.TicketTypeName = 'Child' THEN co.QuantityType ELSE 0 END) AS ChildTickets
FROM
    Event e
JOIN TicketType tt ON e.EventID = tt.EventID
JOIN CustomerOrder co ON tt.TypeID = co.TypeID
WHERE
    e.EventName = 'Exeter Food Festival 2023'
GROUP BY
    e.EventID;

-- task 2: List the event title, starting time and end time, and description



SELECT
    EventName,
    EventStartTime,
    EventEndTime,
    EventDescription
FROM
    Event
WHERE
    EventVenue = 'Exeter'
    AND EventDate BETWEEN '2023-07-01' AND '2023-07-10';


-- Task 3:  List available ticket amount for the Bronze ticket type, together with its price



SELECT
    TicketTypeName,
    TicketTypePrice,
    NumOfTickets - COALESCE(SUM(co.QuantityType), 0) AS AvailableTickets
FROM
    TicketType tt
JOIN Event e ON tt.EventID = e.EventID
LEFT JOIN CustomerOrder co ON tt.TypeID = co.TypeID
WHERE
    e.EventName = 'Exmouth Music Festival 2023' AND
    TicketTypeName = 'Bronze'
GROUP BY
    tt.TicketTypeName, tt.TicketTypePrice, NumOfTickets;


-- task 4:  List all the customer’s names who have booked Gold tickets for the Exmouth Music Festival 2023, together with the number of Gold tickets booked for each customer. 



SELECT
    C.fName AS CustomerFirstName,
    C.lName AS CustomerLastName,
    COUNT(CO.QuantityType) AS NumGoldTickets
FROM
    Customer C
JOIN
    Booking B ON C.CustomerID = B.CustomerID
JOIN
    CustomerOrder CO ON B.BookingID = CO.BookingID
JOIN
    TicketType TT ON CO.TypeID = TT.TypeID
WHERE
    TT.TicketTypeName = 'Gold'
    AND B.EventID = 2  
GROUP BY
    C.CustomerID;



-- Task 5: List all event names and the number of tickets that have been sold for each event so far, ordered by the number of sold tickets in descending order.


SELECT
    e.EventName,
    SUM(co.QuantityType = 'Adult') AS NumAdultTickets,
    SUM(co.QuantityType = 'Child') AS NumChildTickets,
    SUM(co.QuantityType = 'Gold') AS NumGoldTickets,
    SUM(co.QuantityType = 'Silver') AS NumSilverTickets,
    SUM(co.QuantityType = 'Bronze') AS NumBronzeTickets,
    SUM(co.QuantityType IN ('Adult', 'Child', 'Gold', 'Silver', 'Bronze')) AS TotalTicketsSold
FROM
    Event e
LEFT JOIN Booking bo ON e.EventID = bo.EventID
LEFT JOIN CustomerOrder co ON bo.BookingID = co.BookingID
LEFT JOIN TicketType tt ON co.TypeID = tt.TypeID AND e.EventID = tt.EventID
GROUP BY
    e.EventID, e.EventName
ORDER BY
    TotalTicketsSold DESC;


-- Task 6: List all the relevant information by offering a booking ID, such as the customer’s name, booking time, event title, delivery options, ticket types and the number of tickets for each type, the total payment and so on. 

SELECT
    B.BookingID,
    CONCAT(C.fName, ' ', C.lName) AS CustomerName,
    B.BookingDate,
    E.EventName,
    E.EventVenue,
    E.EventDate,
    E.EventStartTime,
    E.EventEndTime,
    TD.DeliveryMethod AS TicketDeliveryMethod,
    TT.TicketTypeName,
    CO.QuantityType AS NumTickets,
    CO.PriceOfAll AS TotalPayment
FROM
    Booking B
JOIN
    Customer C ON B.CustomerID = C.CustomerID
JOIN
    Event E ON B.EventID = E.EventID
JOIN
    TicketDelivery TD ON B.BookingID = TD.BookingID
JOIN
    CustomerOrder CO ON B.BookingID = CO.BookingID
JOIN
    TicketType TT ON CO.TypeID = TT.TypeID

ORDER BY
    B.BookingID;


-- Task 7: List its event title and its total income.

SELECT
    E.EventName,
    SUM(CO.PriceOfAll) AS TotalIncome
FROM
    Event E
JOIN
    Booking B ON E.EventID = B.EventID
JOIN
    CustomerOrder CO ON B.BookingID = CO.BookingID

GROUP BY
    E.EventID, E.EventName
ORDER BY
    TotalIncome DESC
LIMIT 1;















