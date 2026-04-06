DROP TABLE IF EXISTS sales;

# table creation
CREATE TABLE sales(
      transactions_id INT PRIMARY KEY,
      sale_date DATE,
      sale_time TIME,
      customer_id INT,
      gender VARCHAR(15),
      age INT,
      category VARCHAR(15),
      quantity INT,
      price_per_unit FLOAT,
      cogs FLOAT,
      total_sale FLOAT
);


#data cleaning
  SELECT * FROM sales;

SELECT * FROM sales
WHERE 
	transactions_id IS NULL
		OR
    sale_date IS NULL
		OR
    sale_time IS NULL
		OR
    customer_id IS NULL
		OR
    gender IS NULL
		OR
    age IS NULL
		OR
    category IS NULL
		OR
    quantity IS NULL
		OR
    price_per_unit IS NULL
		OR
    cogs IS NULL ;
    
    
# ----------------------------------------data is cleaned and exploration---------------------------------------------------

#--How many sales we have ??
SELECT COUNT(*) as total_sale FROM sales;

#--How many customers we have ??
SELECT COUNT(DISTINCT customer_id) FROM sales;


#----------------------------------------Data Analysis and Business Problems-------------------------------------------
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. 
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

    
    #Answers:
    #-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
    SELECT * FROM sales 
    WHERE sale_date='2022-11-05';
    
    
    #--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
	SELECT * FROM sales
    WHERE category='Clothing' 
		 AND
		 sale_date BETWEEN '2022-11-01' AND '2022-11-30'
         AND
         quantity >= 4;
         
         
     #-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
     SELECT 
		category,
		SUM(total_sale) as net_sale,
		COUNT(*) as total_orders
      FROM sales
	  GROUP BY 1;  
		  
        
	 #-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
     SELECT 
     AVG(age) 
     FROM sales
     WHERE category='Beauty';
     
     
     #-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
     SELECT *
     FROM sales
     WHERE total_sale>1000;
     
     
     #-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
     SELECT  
         category,
         gender,
         COUNT(*) as total_tran
     FROM sales
     GROUP BY 
		 category,
		 gender
     ORDER BY 1;    
		 
         
    #-- Q.7 Write a SQL query to calculate the average sale for each month. 
    SELECT 
       YEAR(sale_date) as year,
       MONTH(sale_date) as month,
       AVG(total_sale) as avg_sale
    FROM sales
    GROUP BY 1,2
    ORDER BY 1,2;
    
    
    #-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
	SELECT 
		customer_id,
		SUM(total_sale) as total_sales
	FROM sales
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5;
    
    
    #-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
	SELECT 
		customer_id,
		SUM(total_sale) as total_sales
	FROM sales
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5;
    
    
    #-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
    WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;


#----------------------------------------------END-----------------------------------------------------------#
    
    
         
    
    
  
   







