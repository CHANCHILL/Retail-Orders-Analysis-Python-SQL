Project Overview:

This project demonstrates an end-to-end analysis of a retail sales dataset using Python and PostgreSQL to extract actionable business insights.
Begins with data retrieval from Kaggle using the Kaggle API, dataset is then processed and cleaned using pandas, and finally loaded into PostgreSQL for analysis to answer potential business intelligence questions.

Business Questions Answered: 
1. Top 10 Revenue-Generating Products (overall)
Which 10 products generated the highest total revenue across all regions and time periods?

2. Top 5 Best-Selling Products by Region
What are the top 5 best-selling products by total quantity sold in each region?

3. Monthly Revenue Growth Comparison (2023 vs 2022)
How does the monthly revenue in 2023 compare to the same months in 2022

4. Top-Selling Product Category by Month
Which product category had the highest total sales in each month?

5. Sub-Category with Highest YoY Profit Growth (2023 compared to 2022)
Which product sub-category experienced the highest YOY profit growth from 2022 to 2023?


Tools & Tech Stack:

1. Python (Python Notebook / VS Code) – for development and documentation
2. Kaggle API – to automate dataset download
3. pandas – for preprocessing and data cleaning 
5. SQLAlchemy and psycopg2 – for PostgreSQL connection and data insertion
4. PostgreSQL – data storage and querying


Project Workflow:

1. Data Retrieval:Download dataset from Kaggle using the Kaggle API.
2. Data cleaning and transformation: Use pandas to handle missing values, format columns, and prepare data for analysis.
3. Load into PostgreSQL and query for analysis: Insert cleaned data into PostgreSQL and write SQL queries to extract business insights.

Outcome:

Cleaned dataset stored/pipeline in PostgreSQL enabling efficient querying and business analysis.