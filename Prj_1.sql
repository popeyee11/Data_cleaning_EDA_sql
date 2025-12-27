select * from layoffs;

-- remove duplicates
-- stadardize data
-- null values or blank values
-- remove any columns

-- * Firstly creating copy of this table

create table layoff_staging
like layoffs;

insert layoff_staging
select * from 
layoffs;

select * from layoff_staging

-- 	-- 	-- 	--	--	--	--	--	--	
