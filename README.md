# Bike Rental Shop - SQL Case Study

## Introduction
Emily is the shop owner, and she would like to gather data to help her grow the business. She has hired you as an SQL specialist to get the answers to her business questions, such as:
- How many bikes does the shop own by category?
- What was the rental revenue for each month?

The answers are hidden in the database. You just need to figure out how to extract them using SQL.

## Case Study Source
This case study is taken from LearnSQL.com. It is part of the **"November 2023 SQL Challenge"** course.

🔗 [LearnSQL.com - November Challenge](https://learnsql.com/course/2023-advanced-sql-practice-challenges/november-challenge/introduction/introduction/)

---

## Database Structure
The shop's database consists of **five tables**:

### 1. Customer Table (`customer`)
Contains details about customers.
| Column | Description |
|--------|-------------|
| id | Unique ID of each customer |
| name | Customer's name |
| email | Customer's email address |

### 2. Bike Table (`bike`)
Contains information about bikes available for rent.
| Column | Description |
|--------|-------------|
| id | Unique ID of the bike |
| model | Model of the bike |
| category | Type of bike (mountain, road, hybrid, electric) |
| price_per_hour | Rental price per hour |
| price_per_day | Rental price per day |
| status | Status of the bike (available, rented, out of service) |

### 3. Rental Table (`rental`)
Tracks bike rentals.
| Column | Description |
|--------|-------------|
| id | Unique ID of the rental entry |
| customer_id | ID of the customer who rented the bike |
| bike_id | ID of the rented bike |
| start_timestamp | Start time of the rental |
| duration | Duration of rental (minutes) |
| total_paid | Total amount paid |

### 4. Membership Type Table (`membership_type`)
Stores information about different membership types.
| Column | Description |
|--------|-------------|
| id | Unique ID of the membership type |
| name | Name of the membership type |
| description | Description of the membership type |
| price | Price of the membership type |

### 5. Membership Table (`membership`)
Tracks purchased memberships.
| Column | Description |
|--------|-------------|
| id | Unique ID of the membership |
| membership_type_id | ID of the purchased membership type |
| customer_id | ID of the customer who purchased it |
| start_date | Start date of membership |
| end_date | End date of membership |
| total_paid | Total amount paid |

---

## Problem Statements
Emily wants answers to several business questions. Solve the following using SQL:

### 1. Count of Bikes by Category
Retrieve the number of bikes available in each category where the count is greater than 2.

### 2. Customer Memberships
Get a list of customer names with the total number of memberships purchased, including those with zero memberships.

### 3. Discounted Rental Prices
Calculate new discounted rental prices:
- Electric bikes: 10% off hourly, 20% off daily.
- Mountain bikes: 20% off hourly, 50% off daily.
- All other bikes: 50% off both hourly and daily.

### 4. Bike Availability Status
Count the number of available and rented bikes per category.

### 5. Rental Revenue Analysis
Calculate total rental revenue:
- Per month
- Per year
- Across all years

### 6. Membership Revenue Analysis
Get total revenue from memberships for each **year, month, and membership type**.

### 7. Membership Sales Report (2023)
Display total membership revenue for 2023 with subtotals and grand totals.

### 8. Customer Segmentation
Categorize customers based on the number of rentals:
- `more than 10` rentals
- `between 5 and 10` rentals
- `fewer than 5` rentals

---

## How to Use
1. Load the dataset into your SQL database.
2. Run the SQL queries to answer the business questions.
3. Check the `SOLUTION` file for reference.
---

## Snapshots

![Image](https://github.com/user-attachments/assets/3acafd4c-a47f-4f25-bd93-6aba337c6b76)

![Image](https://github.com/user-attachments/assets/d0ff6ead-2cda-4ee3-9b4e-e76d76ad2ec2)

## Author
🚀 **[Mohd Arshad]**
📧 Contact: mohdarshad12575@gmail.com

If you found this case study useful, feel free to ⭐ star the repository!
