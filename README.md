Exploratory Data Analysis (EDA) on Layoffs Dataset
Project Overview
This project involves performing exploratory data analysis (EDA) on the layoffs_stagging2 dataset to gain insights into layoffs across various companies, industries, and countries. The analysis examines total layoffs, percentage layoffs, date ranges, and trends over time.

Dataset
The dataset layoffs_stagging2 includes the following columns:

company: Name of the company.
total_laid_off: Total number of layoffs.
percentage_laid_off: Percentage of employees laid off.
funds_raised_millions: Amount of funds raised by the company (in millions).
date: Date of the layoffs.
industry: Industry of the company.
country: Country where the company is located.
stage: Stage of the company (e.g., startup, growth).
SQL Queries
Maximum Total and Percentage Layoffs
sql
Copy code
select max(total_laid_off), max(percentage_laid_off) from layoffs_stagging2;
Retrieves the maximum number of total layoffs and the highest percentage of layoffs from the dataset.
Companies with 100% Layoffs
sql
Copy code
select * from layoffs_stagging2 where percentage_laid_off=1 order by funds_raised_millions desc;
Lists companies where 100% of employees were laid off, sorted by the amount of funds raised.
Total Layoffs by Company
sql
Copy code
select company, sum(total_laid_off) from layoffs_stagging2 group by company order by 2 desc;
Shows total layoffs per company, sorted in descending order by the number of layoffs.
Date Range of Layoffs
sql
Copy code
select min(`date`), max(`date`) from layoffs_stagging2;
Finds the earliest and latest dates in the dataset.
Total Layoffs by Industry
sql
Copy code
select industry, sum(total_laid_off) from layoffs_stagging2 group by industry order by 2 desc;
Displays total layoffs by industry, sorted by the number of layoffs.
Total Layoffs by Country
sql
Copy code
select country, sum(total_laid_off) from layoffs_stagging2 group by country order by 2 desc;
Lists total layoffs by country, sorted by the number of layoffs.
Total Layoffs by Date
sql
Copy code
select `date`, sum(total_laid_off) from layoffs_stagging2 group by `date` order by 1 desc;
Shows total layoffs for each date, sorted by date in descending order.
Total Layoffs by Year
sql
Copy code
select year(`date`), sum(total_laid_off) from layoffs_stagging2 group by year(`date`) order by 1 desc;
Displays total layoffs per year, sorted by year in descending order.
Total Layoffs by Stage
sql
Copy code
select stage, sum(total_laid_off) from layoffs_stagging2 group by stage order by 2 desc;
Shows total layoffs by company stage, sorted by the number of layoffs.
Average Percentage Layoffs by Company
sql
Copy code
select company, avg(percentage_laid_off) from layoffs_stagging2 group by company order by 2 desc;
Lists companies with the average percentage of layoffs, sorted by average percentage.
Monthly Total Layoffs
sql
Copy code
select substring(`date`,6,2) as month, sum(total_laid_off) from layoffs_stagging2 group by month;
Displays total layoffs for each month (by month number).
Total Layoffs by Year-Month
sql
Copy code
select substring(`date`,1,7) as month, sum(total_laid_off) from layoffs_stagging2 where substring(`date`,1,7) is not null group by month order by 1 asc;
Shows total layoffs by year and month, sorted in ascending order.
Rolling Total Layoffs by Month
sql
Copy code
with Rolling_Total as (
    select substring(`date`,1,7) as month, sum(total_laid_off) as total_off from layoffs_stagging2 
    where substring(`date`,1,7) is not null 
    group by month 
    order by 1 asc
)
select month, total_off, sum(total_off) over(order by month) as rolling_total from Rolling_Total;
Calculates the rolling total of layoffs by month.
Company Layoffs by Year
sql
Copy code
select company, year(`date`), sum(total_laid_off) from layoffs_stagging2 group by company, year(`date`) order by 3 desc;
Displays total layoffs by company and year, sorted by the number of layoffs.
Top 5 Companies by Layoffs per Year
sql
Copy code
with Company_Year(company, years, total_laid_off) as (
    select company, year(`date`), sum(total_laid_off) from layoffs_stagging2 group by company, year(`date`)
),
Company_Year_rank as (
    select *, dense_rank() over(partition by years order by total_laid_off desc) as ranking from Company_Year where years is not null
)
select * from Company_Year_rank where ranking <= 5;
Lists the top 5 companies with the highest layoffs for each year.



