
USE INSURANCE_PROJECT;

/*CROSS SELL*/
SELECT concat(format(sum(`Cross Sell Bugdet`)/1000000,2),' M') AS 'CrossSell Target' FROM  budget;
SELECT concat(format(((SELECT SUM(Amount) FROM brokerage WHERE income_class = 'Cross sell')+(SELECT SUM(Amount) FROM fees WHERE income_class = 'Cross sell'))/1000000,2),' M') AS 'CrossSell Achieved';
SELECT concat(format(((SELECT SUM(Amount) FROM brokerage WHERE income_class='Cross sell')+(SELECT SUM(Amount) FROM fees WHERE income_class = 'Cross sell'))/(SELECT SUM(`Cross Sell Bugdet`) FROM budget)*100,2),'% ',case  when ((SELECT SUM(Amount) FROM brokerage WHERE income_class='Cross sell')+(SELECT SUM(Amount) FROM fees WHERE income_class = 'Cross sell'))/(SELECT SUM(`Cross Sell Bugdet`) FROM budget)<1 then '▼' else '▲' end) AS 'Crss Sell Plcd Achvmnt %';
SELECT concat(format(SUM(Amount)/1000000,2),' M') AS 'Cross Sell Invoice' FROM invoice WHERE income_Class='Cross Sell';
SELECT concat(format((SELECT SUM(Amount) FROM invoice WHERE income_Class='Cross Sell')/(SELECT SUM(`Cross Sell Bugdet`) FROM budget)*100,2),'% ',case when ((SELECT SUM(Amount) FROM invoice WHERE income_Class='Cross Sell')/(SELECT SUM(`Cross Sell Bugdet`) FROM budget))<1 then '▼' else '▲' end) AS 'Crss Sell Invoice Achvmnt %';

/*NEW*/
SELECT concat(format(SUM(`New Budget`)/1000000,2),' M') AS 'New Target' FROM budget;
SELECT concat(format(((SELECT SUM(Amount) FROM brokerage WHERE income_class = 'New')+(SELECT SUM(Amount) FROM fees WHERE income_class = 'New'))/1000000,2),' M') AS 'New Achieved';
SELECT concat(format(((SELECT SUM(Amount) FROM brokerage WHERE income_class='New')+(SELECT SUM(Amount) FROM fees WHERE income_class = 'New'))/(SELECT SUM(`New Budget`) FROM BUDGET)*100,2),'% ',case when (((SELECT SUM(Amount) FROM brokerage WHERE income_class='New')+(SELECT SUM(Amount) FROM fees WHERE income_class = 'New'))/(SELECT SUM(`New Budget`) FROM budget))<1 then '▼' else '▲' end) AS 'New Plcd Achvmnt %';
SELECT concat(format(SUM(Amount)/1000000,2),' M') AS 'New Invoice' FROM invoice WHERE income_Class='New';
SELECT concat(format((SELECT SUM(Amount) FROM invoice WHERE income_Class='New')/(SELECT SUM(`New Budget`) FROM budget)*100,2),'% ',case when ((SELECT SUM(Amount) FROM invoice WHERE income_Class='New')/(SELECT SUM(`New Budget`) FROM budget))<1 then '▼' else '▲' end) AS 'New Invoice Achvmnt %';

/*RENEWAL*/
SELECT concat(format(SUM(`Renewal Budget`)/1000000,2),' M') AS 'Renewal Target' FROM budget;
SELECT concat(format(((SELECT SUM(Amount) FROM brokerage WHERE income_class = 'Renewal')+(SELECT SUM(Amount) FROM fees WHERE income_class = 'Renewal'))/1000000,2),' M') AS 'Renewal Achieved';
SELECT concat(format(((SELECT SUM(Amount) FROM brokerage WHERE income_class='Renewal')+(SELECT SUM(Amount) FROM fees WHERE income_class = 'Renewal'))/(SELECT SUM(`Renewal Budget`) FROM budget)*100,2),'% ',case when (((SELECT SUM(Amount) FROM brokerage WHERE income_class='Renewal')+(SELECT SUM(Amount) FROM fees WHERE income_class = 'Renewal'))/(SELECT SUM(`Renewal Budget`) FROM budget))<1 then '▼' else '▲' end) AS 'Renewal Plcd Achvmnt %';
SELECT concat(format(SUM(Amount)/1000000,2),' M') AS 'Renewal Invoice' FROM invoice WHERE income_Class='Renewal';
SELECT concat(format((SELECT SUM(Amount) FROM invoice WHERE income_Class='Renewal')/(SELECT SUM(`Renewal Budget`) FROM budget)*100,2),'% ',case when ((SELECT SUM(Amount) FROM invoice WHERE income_Class='Renewal')/(SELECT SUM(`Renewal Budget`) FROM budget))<1 then '▼' else '▲' end) AS 'Renewal Invoice Achvmnt %';

/*YEARLY MEETING COUNT*/
SELECT (SELECT count(meeting_date) from meeting where year(DATE_FORMAT(STR_TO_DATE(meeting_date, '%d-%m-%Y'), '%Y-%m-%d'))=2019) as '2019 meeting count',(SELECT count(meeting_date) from meeting where year(DATE_FORMAT(STR_TO_DATE(meeting_date, '%d-%m-%Y'), '%Y-%m-%d'))=2020) as '2020 meeting count';

/*No of Meeting by Accnt Exec*/
SELECT `Account Executive`,count(meeting_date) AS No_of_Meeting_by_Accnt_Exec from meeting group by `Account Executive` order by 2 desc;


/*No of Invoices by Accnt Exec*/

#ALTER TABLE INVOICE CHANGE COLUMN `ï»¿INVOICE_NUMBER` `INVOICE_NUMBER` TEXT;

WITH InvoiceCounts AS (SELECT `Account Executive`,income_class,COUNT(invoice_number) AS invoice_count FROM invoice GROUP BY 1,2),AccountExecCounts AS (SELECT `Account Executive`,SUM(invoice_count) AS total_invoice_count FROM InvoiceCounts GROUP BY 1) SELECT ic.`Account Executive`,ic.income_class,ic.invoice_count as 'No of Invoice by Accnt Exec',aec.total_invoice_count FROM InvoiceCounts ic JOIN AccountExecCounts aec ON ic.`Account Executive`= aec.`Account Executive` ORDER BY 4 DESC,ic.income_class;

/*Opportunities*/


SELECT (SELECT count(opportunity_name) from Opportunity) AS 'Total Opportunities',(SELECT count(opportunity_name) from Opportunity where (stage='Qualify Opportunity' or stage='Propose Solution')) AS 'Total Open Opportunities';

/*Oppty by Revenue-Top 4*/
SELECT opportunity_name,concat(format(sum(revenue_amount)/1000000,2),' M') AS 'Oppty by Revenue-Top 4' from Opportunity group by 1 order by 2 desc limit 4;

/*Stage by Revenue*/
SELECT stage,concat(format(sum(revenue_amount)/1000000,2),' M') as Revenue,concat(Format((sum(revenue_amount)/(Select sum(revenue_amount) from Opportunity))*100,2),' %') AS 'Stage by Revenue' from Opportunity group by 1;

/*Oppty-Product distribution*/
SELECT product_group,count(opportunity_name) AS 'Oppty-Product distribution' from Opportunity group by 1 order by 2 desc;

/*Open Oppty-Top 4*/
SELECT opportunity_name,concat(format(sum(revenue_amount)/1000000,2),' M') AS 'Open Oppty-Top 4' from Opportunity where (stage='Qualify Opportunity' or stage='Propose Solution') group by 1 order by 2 desc limit 7;