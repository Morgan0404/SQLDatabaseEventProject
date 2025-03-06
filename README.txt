# Online Ticket Booking System

A MySQL-based database system for managing event ticket bookings, featuring conceptual (ERD), logical (relational), and physical (SQL) designs.

## Overview
This project implements an online ticket booking system for events like circuses and concerts. It supports:
- Event details with ticket types (e.g., adult, child) and quantities.
- Voucher discounts and customer bookings with payment via credit/debit cards.
- Booking cancellations and data queries/updates.

## Files
- `ticket_design.pdf`: Design report with UML ERD and relational model.
- `ticket_init.sql`: Creates and populates the database tables.
- `ticket_query.sql`: Executes 7 predefined queries (e.g., event listings, ticket sales).
- `ticket_update.sql`: Implements 4 update operations (e.g., ticket additions, cancellations).

## Setup
1. **Requirements**: MySQL installed (e.g., MySQL Workbench).
2. **Database Creation**:
   - Run `ticket_init.sql` in MySQL to create and populate tables:
     ```bash
     mysql -u username -p < ticket_init.sql