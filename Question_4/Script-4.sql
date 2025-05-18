
--Task 4: Data Integration via sql
--Joins the three tables into a unified dataset (structure based on common keys/columns)

--Joining all tables

with a as (
SELECT 
    c.id,
    case when c.gender ='F' then 'Female'
        	 when c.gender ='M' then 'Male'
        	 else c.gender end as gender,
    c.age,
    c.province,
    c.income,
    c.bank,
    c.num_products,
    c.client_duration,
    c.payment,
    c.distrn,
    
    hl."option",
    hl."family",
    hl.lapse_indicator,
    
    hp.single_premium,
    hp.couple_premium,
    hp.family_premium

FROM public.clients c
LEFT JOIN public.health_lapses hl 
    ON c.id = hl.id
LEFT JOIN public.health_products hp  
    ON hl."option" = hp."option")
    
    select * from a;

--Are there any duplicate rows based on the id column, and if so, how many?
--WE didn't get any duplicated id's
with unified_dataset as
	(SELECT 
    c.id,
    case when c.gender ='F' then 'Female'
        	 when c.gender ='M' then 'Male'
        	 else c.gender end as gender,
    c.age,
    c.province,
    c.income,
    c.bank,
    c.num_products,
    c.client_duration,
    c.payment,
    c.distrn,
    
    hl."option",
    hl."family",
    hl.lapse_indicator,
    
    hp.single_premium,
    hp.couple_premium,
    hp.family_premium

FROM public.clients c
LEFT JOIN public.health_lapses hl 
    ON c.id = hl.id
LEFT JOIN public.health_products hp  
    ON hl."option" = hp."option")
    
SELECT id, COUNT(*) AS count
FROM unified_dataset
GROUP BY id
HAVING COUNT(*) > 1;

--What is the mean income per province and gender? If the income value is NULL, impute the NULL values. Provide motivation for your method of imputation.

/*Median was used instead of mean for income imputation because it provides a more robust and reliable central value, especially when the data is skewed or contains outliers.
Income distributions often have a long tail of high earners, which can significantly inflate the mean and misrepresent the typical value*/

With unified_dataset as
	(SELECT 
    c.id,
    case when c.gender ='F' then 'Female'
        	 when c.gender ='M' then 'Male'
        	 else c.gender end as gender,
    c.age,
    c.province,
    c.income,
    c.bank,
    c.num_products,
    c.client_duration,
    c.payment,
    c.distrn,
    
    hl."option",
    hl."family",
    hl.lapse_indicator,
    
    hp.single_premium,
    hp.couple_premium,
    hp.family_premium

FROM public.clients c
LEFT JOIN public.health_lapses hl 
    ON c.id = hl.id
LEFT JOIN public.health_products hp  
    ON hl."option" = hp."option")
,
 median_income AS (
  SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY income) AS median_income
  FROM unified_dataset
  WHERE income IS NOT NULL
),
imputed AS (
  SELECT *,
         COALESCE(income, (SELECT median_income FROM median_income)) AS fixed_income
  FROM unified_dataset
)
SELECT province, gender, AVG(fixed_income) AS avg_income
FROM imputed
GROUP BY province, gender;



--Imputation based median per province ,gender (most accurate than using the overal median)

WITH unified_dataset AS (
    SELECT 
        c.id,
        case when c.gender ='F' then 'Female'
        	 when c.gender ='M' then 'Male'
        	 else c.gender end as gender,
        c.age,
        c.province,
        c.income,
        c.bank,
        c.num_products,
        c.client_duration,
        c.payment,
        c.distrn,
        hl."option",
        hl."family",
        hl.lapse_indicator,
        hp.single_premium,
        hp.couple_premium,
        hp.family_premium
    FROM public.clients c
    LEFT JOIN public.health_lapses hl ON c.id = hl.id
    LEFT JOIN public.health_products hp ON hl."option" = hp."option"
),
median_income AS 
(
    SELECT 
        province,
        gender,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY income) AS median_income
    FROM unified_dataset
    WHERE income IS NOT NULL
    GROUP BY province, gender
),
imputed AS (
    SELECT 
        ud.*,
        COALESCE(
            ud.income, 
            mi.median_income
        ) AS fixed_income
    FROM unified_dataset ud
    LEFT JOIN median_income mi 
        ON ud.province = mi.province 
       AND ud.gender = mi.gender
)

SELECT province, gender, AVG(fixed_income) AS avg_income
FROM imputed
GROUP BY province, gender;



--Which payment method is used by most customers per bank?
--Most customers use Debit Orders
WITH most_used_payment as( 
SELECT bank, payment,count(id) payment_counts
from clients
group by 1,2),
ranked_payments as (
select * ,ROW_NUMBER() OVER (PARTITION BY bank ORDER BY payment_counts DESC) AS rn 
from most_used_payment)

select bank, payment, payment_counts from ranked_payments
where rn =1
and bank is not null




