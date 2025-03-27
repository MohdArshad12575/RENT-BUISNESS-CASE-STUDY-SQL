
-- 1 Emily would like to know how many bikes the shop owns by category. Can 
-- you get this for her? 
-- Display the category name and the number of bikes the shop owns in 
-- each category (call this column number_of_bikes ). Show only the categories where the number of bikes is greater than 2

SELECT category,
COUNT(model) noofbikes_own
FROM bike 
GROUP BY category
HAVING noofbikes_own > 2 ;

-- 2 Emily needs a list of customer names with the total number of 
--  memberships purchased by each.
--  For each customer, display the customer's name and the count of memberships purchased (call this column 
--  membership_count ). Sort the results by membership_count , starting with the customer who has purchased 
--  the highest number of memberships.

SELECT name,
COUNT(1) membership_count
FROM membership m
JOIN customer c
ON m.customer_id = c.id
GROUP BY customer_id,name
ORDER BY membership_count DESC ;

-- 3 Emily is working on a special offer for the winter months. Can you help her 
--  prepare a list of new rental prices?
--  For each bike, display its ID, category, old price per hour (call this column old_price_per_hour ), 
--  discounted price per hour (call it new_price_per_hour ),
--  old  price per day (call it old_price_per_day ), and discounted price per day (call it new_price_per_day ).
--   Electric bikes should have a 10% discount for hourly rentals and a 20% discount for daily rentals. 
--   Mountain bikes should have a 20% discount for hourly rentals and a 50% discount for daily rentals.
--   All other bikes should have a 50% discount for all types of rentals. Round the new prices to 2 decimal digits.
SELECT  id,category,price_per_hour AS old_price_per_hour,
ROUND(CASE WHEN category = 'electric' THEN price_per_hour * 0.90 
     WHEN category = 'mountain' THEN price_per_hour * 0.80 
	 ELSE price_per_hour * 0.50 
END ,2) AS new_price_per_hour,
price_per_day AS old_price_per_day,
ROUND(CASE WHEN category = 'electric' THEN price_per_day * 0.80 
     WHEN category = 'mountain' THEN price_per_day * 0.50
	 ELSE price_per_day * 0.50
END ,2) AS new_price_per_day
FROM bike;

-- 4  Emily is looking for counts of the rented bikes and of the available bikes in 
--  each category. Display the number of available bikes (call this column available_bikes_count ) 
--  and the number of rented bikes (call this column rented_bikes_count ) by bike category.

SELECT DISTINCT category,
SUM(CASE WHEN status = 'available' THEN 1 ELSE 0 END) AS available_bikes_count,
SUM(CASE WHEN status = 'rented' THEN 1 ELSE 0  END) AS rented_bikes_count
FROM bike
GROUP BY category;

-- 5 Emily is preparing a sales report. She needs to know the total revenue 
--   from rentals by month, the total by year, and the all-time across all the years.
--  Display the total revenue from rentals for each month, the total for each 
--  year, and the total across all the years. Do not take memberships into 
--  account. There should be 3 columns: year , month , and revenue .
--  Sort the results chronologically. Display the year total after all the month 
--  totals for the corresponding year. Show the all-time total as the last row.

SELECT 
CASE WHEN year IS NULL THEN 'Grand Total' ELSE year END AS year,
CASE WHEN month IS NULL THEN 'total' ELSE month END AS monthname ,
rev
FROM 
(SELECT YEAR(start_timestamp) year,
MONTHNAME(start_timestamp) month,
SUM(total_paid) rev
FROM rental 
GROUP BY YEAR(start_timestamp),
MONTHNAME(start_timestamp) WITH ROLLUP )t ;

-- 6 Emily has asked you to get the total revenue from memberships for each 
--   combination of year, month, and membership type.
--   Display the year, the month, the name of the membership type (call this column membership_type_name ),
--   and the total revenue (call this column total_revenue ) for every combination of year, month, and membership type. 
--   Sort the results by year, month, and name of membership type.

SELECT YEAR(start_date) year,
MONTHNAME(start_date) month,
name membership_type_name,
SUM(total_paid) total_rev
FROM membership m
JOIN membership_type mt
ON m.membership_type_id = mt.id
GROUP BY YEAR(start_date),
MONTH(start_date),
MONTHNAME(start_date),name
ORDER BY year,MONTH(start_date);

-- 7 Next, Emily would like data about memberships purchased in 2023, with 
--  subtotals and grand totals for all the different combinations of membership types and months.
--  Display the total revenue from memberships purchased in 2023 for each 
--  combination of month and membership type. Generate subtotals and grand totals for all possible combinations.  
--  There should be 3 columns: membership_type_name , month , and total_revenue .
--  Sort the results by membership type name alphabetically and then chronologically by month.


SELECT 
CASE WHEN month IS NULL THEN 'Grand Total' ELSE month END AS monthname,
CASE WHEN membership_plan IS NULL THEN 'total' ELSE membership_plan END AS plan ,
rev 
FROM 
(SELECT MONTHNAME(start_date) month,
mt.name membership_plan,
SUM(total_paid) rev
FROM membership m
JOIN membership_type mt
ON m.membership_type_id = mt.id
WHERE YEAR(start_date) = 2023
GROUP BY MONTHNAME(start_date),
mt.name WITH ROLLUP )t;

-- 8 Now it's time for the final task.Emily wants to segment customers based on the number of rentals and 
--   see the count of customers in each segment. Use your SQL skills to get this!
--  Categorize customers based on their rental history as follows:
--  Customers who have had more than 10 rentals are categorized as 'more than 10' 
--  Customers who have had 5 to 10 rentals (inclusive) are categorized as 'between 5 and 10' .
--  Customers who have had fewer than 5 rentals should be categorized as 'fewer than 5' .
--  Calculate the number of customers in each category. Display two columns: 
-- rental_count_category (the rental count category) and number of customers in each category).

WITH categorized_cust 
AS ( SELECT c.id customer_id,c.name customer_name,
     COUNT(*) noofrentals
     FROM customer c
     JOIN rental r
     ON c.id = r.customer_id
     GROUP BY c.id ) 
, rental_Category
AS ( SELECT customer_id,customer_name, noofrentals,
     CASE 
         WHEN noofrentals > 10 THEN 'More than 10' 
         WHEN noofrentals BETWEEN 5 AND 10 THEN 'Between 5 And 10'
         ELSE 'Fewer than 5'
	 END AS category
     FROM categorized_cust )
SELECT category rental_count_category,
COUNT(*) noofcustomer
FROM rental_category
GROUP BY category;