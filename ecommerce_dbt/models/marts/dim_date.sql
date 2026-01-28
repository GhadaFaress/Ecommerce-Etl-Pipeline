-- models/marts/core/dim_date.sql
{{ config(
    materialized='table',
    tags=['dimension']
) }}

WITH date_spine AS (
    -- Generate dates from 2016-01-01 to 2019-12-31 (covers Olist data + buffer)
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2016-01-01' as date)",
        end_date="cast('2019-12-31' as date)"
    ) }}
),

date_dimension AS (
    SELECT
        date_day,
        
        -- Date identifiers
        DATE_PART('year', date_day) * 10000 + 
        DATE_PART('month', date_day) * 100 + 
        DATE_PART('day', date_day) AS date_key,
        
        -- Year attributes
        DATE_PART('year', date_day) AS year,
        DATE_PART('quarter', date_day) AS quarter,
        'Q' || DATE_PART('quarter', date_day) || ' ' || DATE_PART('year', date_day) AS quarter_name,
        
        -- Month attributes
        DATE_PART('month', date_day) AS month_number,
        TO_CHAR(date_day, 'Month') AS month_name,
        TO_CHAR(date_day, 'Mon') AS month_short_name,
        DATE_TRUNC('month', date_day) AS month_start_date,
        
        -- Week attributes
        DATE_PART('week', date_day) AS week_of_year,
        DATE_TRUNC('week', date_day) AS week_start_date,
        
        -- Day attributes
        DATE_PART('day', date_day) AS day_of_month,
        DATE_PART('dayofweek', date_day) AS day_of_week,
        TO_CHAR(date_day, 'Day') AS day_name,
        TO_CHAR(date_day, 'Dy') AS day_short_name,
        DATE_PART('dayofyear', date_day) AS day_of_year,
        
        -- Flags
        CASE WHEN DATE_PART('dayofweek', date_day) IN (0, 6) THEN TRUE ELSE FALSE END AS is_weekend,
        CASE WHEN DATE_PART('dayofweek', date_day) BETWEEN 1 AND 5 THEN TRUE ELSE FALSE END AS is_weekday,
        
        -- Fiscal attributes (adjust if needed)
        CASE 
            WHEN DATE_PART('month', date_day) >= 10 THEN DATE_PART('year', date_day) + 1
            ELSE DATE_PART('year', date_day)
        END AS fiscal_year,
        
        -- Display formats
        TO_CHAR(date_day, 'YYYY-MM-DD') AS date_iso,
        TO_CHAR(date_day, 'DD/MM/YYYY') AS date_br_format
        
    FROM date_spine
)

SELECT * FROM date_dimension
ORDER BY date_day