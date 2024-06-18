-- Exploratry data analysis

select max(total_laid_off),max(percentage_laid_off) from layoffs_stagging2; 

select*from layoffs_stagging2 where percentage_laid_off=1
order by funds_raised_millions desc;

select company,sum(total_laid_off) from layoffs_stagging2 group by company order by 2 desc;       -- 2 means position in that is total_laif=d_off

select min(`date`),max(`date`) from layoffs_stagging2;

select industry,sum(total_laid_off) from layoffs_stagging2 group by industry order by 2 desc;       

select country,sum(total_laid_off) from layoffs_stagging2 group by country order by 2 desc;    

select `date`,sum(total_laid_off) from layoffs_stagging2 group by `date` order by 1 desc;       

select year(`date`),sum(total_laid_off) from layoffs_stagging2 group by year(`date` )order by 1 desc;  


select stage,sum(total_laid_off) from layoffs_stagging2 group by stage order by 2 desc;      



select company,avg(percentage_laid_off) from layoffs_stagging2 group by company order by 2 desc;    



select substring(`date`,6,2) as month,sum(total_laid_off) from layoffs_stagging2 group by month;


select substring(`date`,1,7) as month,sum(total_laid_off) from layoffs_stagging2 where  substring(`date`,1,7)  is not null group by month order by  1 asc;

with Rolling_Total as (select substring(`date`,1,7) 
as month,sum(total_laid_off) as total_off from layoffs_stagging2 where 
substring(`date`,1,7)  is not null group by
 month order by  1 asc)
select month,total_off, sum(total_off) over( order by month)   as rolling_total from Rolling_Total;


select company,year(`date`), sum(total_laid_off) from layoffs_stagging2 group by company,year(`date`) order by 3 desc;

with Company_Year(company,years,total_laid_off) as(
select company,year(`date`), sum(total_laid_off) from layoffs_stagging2 group by company,year(`date`)
),Company_Year_rank as(
select *,
dense_rank() over(partition by years order by total_laid_off desc) as ranking
from Company_Year
where years is not null )
select *from company_year_rank
where ranking<=5;        

