# Exploratory Data Analysis (EDA) on Layoffs Dataset

## Overview

This project involves performing exploratory data analysis (EDA) on the `layoffs_stagging2` dataset. The aim is to gain insights into layoffs across various companies, industries, and countries by examining total layoffs, percentage layoffs, date ranges, and trends over time.

## Files

- `eda_queries.sql`: Contains SQL queries for performing EDA.
- `layoffs_stagging2`: Dataset used for analysis.

## SQL Queries and Steps

### 1. Maximum Total and Percentage Layoffs
```sql
SELECT MAX(total_laid_off), MAX(percentage_laid_off) FROM layoffs_stagging2;
```
- Retrieves the maximum number of total layoffs and the highest percentage of layoffs from the dataset.

### 2. Companies with 100% Layoffs
```sql
SELECT * FROM layoffs_stagging2 WHERE percentage_laid_off = 1 ORDER BY funds_raised_millions DESC;
```
- Lists companies where 100% of employees were laid off, sorted by the amount of funds raised.

### 3. Total Layoffs by Company
```sql
SELECT company, SUM(total_laid_off) FROM layoffs_stagging2 GROUP BY company ORDER BY 2 DESC;
```
- Shows total layoffs per company, sorted in descending order by the number of layoffs.

### 4. Date Range of Layoffs
```sql
SELECT MIN(`date`), MAX(`date`) FROM layoffs_stagging2;
```
- Finds the earliest and latest dates in the dataset.

### 5. Total Layoffs by Industry
```sql
SELECT industry, SUM(total_laid_off) FROM layoffs_stagging2 GROUP BY industry ORDER BY 2 DESC;
```
- Displays total layoffs by industry, sorted by the number of layoffs.

### 6. Total Layoffs by Country
```sql
SELECT country, SUM(total_laid_off) FROM layoffs_stagging2 GROUP BY country ORDER BY 2 DESC;
```
- Lists total layoffs by country, sorted by the number of layoffs.

### 7. Total Layoffs by Date
```sql
SELECT `date`, SUM(total_laid_off) FROM layoffs_stagging2 GROUP BY `date` ORDER BY 1 DESC;
```
- Shows total layoffs for each date, sorted by date in descending order.

### 8. Total Layoffs by Year
```sql
SELECT YEAR(`date`), SUM(total_laid_off) FROM layoffs_stagging2 GROUP BY YEAR(`date`) ORDER BY 1 DESC;
```
- Displays total layoffs per year, sorted by year in descending order.

### 9. Total Layoffs by Stage
```sql
SELECT stage, SUM(total_laid_off) FROM layoffs_stagging2 GROUP BY stage ORDER BY 2 DESC;
```
- Shows total layoffs by company stage, sorted by the number of layoffs.

### 10. Average Percentage Layoffs by Company
```sql
SELECT company, AVG(percentage_laid_off) FROM layoffs_stagging2 GROUP BY company ORDER BY 2 DESC;
```
- Lists companies with the average percentage of layoffs, sorted by average percentage.

### 11. Monthly Total Layoffs
```sql
SELECT SUBSTRING(`date`, 6, 2) AS month, SUM(total_laid_off) FROM layoffs_stagging2 GROUP BY month;
```
- Displays total layoffs for each month (by month number).

### 12. Total Layoffs by Year-Month
```sql
SELECT SUBSTRING(`date`, 1, 7) AS month, SUM(total_laid_off) FROM layoffs_stagging2 WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL GROUP BY month ORDER BY 1 ASC;
```
- Shows total layoffs by year and month, sorted in ascending order.

### 13. Rolling Total Layoffs by Month
```sql
WITH Rolling_Total AS (
    SELECT SUBSTRING(`date`, 1, 7) AS month, SUM(total_laid_off) AS total_off FROM layoffs_stagging2 
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL 
    GROUP BY month 
    ORDER BY 1 ASC
)
SELECT month, total_off, SUM(total_off) OVER(ORDER BY month) AS rolling_total FROM Rolling_Total;
```
- Calculates the rolling total of layoffs by month.

### 14. Company Layoffs by Year
```sql
SELECT company, YEAR(`date`), SUM(total_laid_off) FROM layoffs_stagging2 GROUP BY company, YEAR(`date`) ORDER BY 3 DESC;
```
- Displays total layoffs by company and year, sorted by the number of layoffs.

### 15. Top 5 Companies by Layoffs per Year
```sql
WITH Company_Year AS (
    SELECT company, YEAR(`date`), SUM(total_laid_off) FROM layoffs_stagging2 GROUP BY company, YEAR(`date`)
),
Company_Year_rank AS (
    SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking FROM Company_Year WHERE years IS NOT NULL
)
SELECT * FROM Company_Year_rank WHERE ranking <= 5;
```
- Lists the top 5 companies with the highest layoffs for each year.

Feel free to explore the queries and modify them as needed to derive additional insights from the dataset.
