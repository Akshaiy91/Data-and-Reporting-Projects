-- Top industries by operating profit (latest quarter)
SELECT Series_title_2 AS industry, 
       ROUND(SUM(Data_value), 2) AS total_profit_millions
FROM financial_data
WHERE Series_title_1 = 'Operating profit'
AND Period = 2026.06
AND "Group" = 'Industry by financial variable (NZSIOC Level 1)'
GROUP BY Series_title_2
ORDER BY total_profit_millions DESC;

-- Salary growth over time across all industries
SELECT Period, 
       ROUND(SUM(Data_value), 2) AS total_salaries_millions
FROM financial_data
WHERE Series_title_1 = 'Salaries and wages'
AND "Group" = 'Industry by financial variable (NZSIOC Level 1)'
GROUP BY Period
ORDER BY Period;

-- Profit margin proxy: profit vs sales by industry
SELECT Series_title_2 AS industry,
       ROUND(SUM(CASE WHEN Series_title_1 = 'Operating profit' THEN Data_value ELSE 0 END), 2) AS profit,
       ROUND(SUM(CASE WHEN Series_title_1 = 'Sales (operating income)' THEN Data_value ELSE 0 END), 2) AS sales,
       ROUND(SUM(CASE WHEN Series_title_1 = 'Operating profit' THEN Data_value ELSE 0 END) * 100.0 /
             NULLIF(SUM(CASE WHEN Series_title_1 = 'Sales (operating income)' THEN Data_value ELSE 0 END), 0), 1) AS profit_margin_pct
FROM financial_data
WHERE Period = 2026.06
AND "Group" = 'Industry by financial variable (NZSIOC Level 1)'
GROUP BY Series_title_2
ORDER BY profit_margin_pct DESC;