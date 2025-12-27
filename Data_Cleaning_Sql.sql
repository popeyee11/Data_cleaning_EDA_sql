-- removing duplicates from data
select * from layoff_staging;

select *,
row_number() over(partition by 
company,location,industry,total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions) as row_num
from layoff_staging;

with duplicate_cte as
(
select *,
row_number() over(partition by 
company,location,industry,total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions) as row_num
from layoff_staging
)
select * from duplicate_cte
where row_num > 1;


-- --	--	--	--	--		--			---			--		---	

CREATE TABLE `layoff_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoff_staging_2
where row_num>1;

insert into layoff_staging_2
select *,
row_number() over(partition by 
company,location,industry,total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions) as row_num
from layoff_staging;

select * from layoff_staging_2;

delete from layoff_staging_2
where row_num > 1
;

select * from layoff_staging_2
where row_num=2; 


-- standardizing data--
select company, trim(company) 
from layoff_staging_2;

update layoff_staging_2
set company=trim(company);

select distinct industry
from layoff_staging_2
order by 1;		-- for checking null/blanck values and ordering by A to Z

select * from layoff_staging_2
where industry like '%crypto%' ;  -- finding out crypto named same to same

update layoff_staging_2
set industry='crypto'
where industry like '%crypto%' ;		-- updated all crypto name with one name

select distinct country 
from layoff_staging_2
order by 1;

update layoff_staging_2
set country='United States'
where country like '%United States%';

select * from layoff_staging_2;


select `date`,
case
	when `date` like '%/%' then str_to_date(`date`, '%m/%d/%Y')
	when `date` like '%-%' then str_to_date(`date`, '%m-%d-%Y')
    else null
end as stadardized_date
from layoff_staging_2;

update layoff_staging_2
set `date`=
case
	when `date` like '%/%' then str_to_date(`date`, '%m/%d/%Y')
	when `date` like '%-%' then str_to_date(`date`, '%m-%d-%Y')
    else null
end;

select `date` from layoff_staging_2;


