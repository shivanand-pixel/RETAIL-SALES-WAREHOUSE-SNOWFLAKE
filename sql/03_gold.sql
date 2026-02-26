USE WAREHOUSE COMPUTE_WH;
USE DATABASE SNOWFLAKE_LEARNING_DB;

CREATE SCHEMA if not exists GOLD;
CREATE OR REPLACE TABLE GOLD.SALES_BY_STATE AS
SELECT
    d.state,
    SUM(f.sales_price) AS total_sales
FROM SILVER.FACT_SALES f
JOIN SILVER.CUSTOMER_DIM d
    ON f.customer_sk = d.customer_sk
GROUP BY d.state;
select * from silver.customer_dim;
select * from silver.fact_sales limit 10;
create or replace table GOLD.SALES_BY_YEAR AS
SELECT YEAR (TRANSACTION_DATE) AS SALES_YEAR,
SUM(SALES_PRICE) AS TOTAL_SALES
FROM SILVER.FACT_SALES GROUP BY  SALES_YEAR;


SELECT * FROM GOLD.SALES_BY_YEAR;

create or replace table gold.monthly_sales as
select date_trunc('month',transaction_date) as sales_month,
sum(sales_price) as total_sales
from silver.fact_sales
group by sales_month;



create or replace table gold.top_stores as
select store_id,
sum(sales_price) as total_sales
from silver.fact_sales
group by store_id 
order by total_sales desc
limit 10;

select count(*) from gold.SALES_BY_STATE;

select count(*) from gold.SALES_BY_YEAR;
select count(*) from gold.monthly_sales;

select count(*) from gold.top_stores;


select* from silver.fact_sales;


select sum(sales_price) from silver.fact_sales;
