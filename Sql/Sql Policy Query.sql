USE INSURANCE_PROJECT;
#1.TOTAL POLICY
SELECT COUNT(*) AS Total_Policy FROM policy_details;

#2. TOTAL CUSTOMERS
SELECT COUNT(DISTINCT `Customer ID`) AS Total_Customers FROM policy_details;

#3.AGE BUCKET WISE POLICY COUNT


SELECT c.`Age Group`, COUNT(*) AS Policy_Count FROM customer_info c
JOIN policy_details p
ON c.`Customer ID` = p.`Customer ID` GROUP BY c.`Age Group`;

#4. GENDER WISE POLICY COUNT
SELECT c.Gender, COUNT(*) AS Policy_Count FROM customer_info c
JOIN policy_details p
ON c.`Customer ID` = p.`Customer ID` GROUP BY c.Gender ORDER BY Policy_Count DESC;

#5.POLICY TYPE WISE POLICY COUNT
SELECT `Policy Type`, COUNT(*) AS Policy_Count
FROM policy_details GROUP BY `Policy Type` ORDER BY Policy_Count DESC;

#6.POLICY EXPIRE THIS YEAR
SELECT COUNT(*) AS Policies_Expiring_This_Year
FROM policy_details
WHERE YEAR(STR_TO_DATE(`Policy End Date`, '%d-%m-%Y')) = YEAR(CURDATE());

#7.PREMIUM GROWTH RATE
SELECT YEAR(STR_TO_DATE(`Policy Start Date`, '%d-%m-%Y')) AS Year, ROUND(SUM(`Premium Amount`),2) AS Total_Premium
FROM policy_details
GROUP BY YEAR(STR_TO_DATE(`Policy Start Date`, '%d-%m-%Y'))
ORDER BY Year;

#8.CLAIM STATUS WISE POLICY COUNT
SELECT `Claim Status`, COUNT(*) AS Policy_Count FROM claims GROUP BY `Claim Status` ORDER BY Policy_Count DESC;

#9.PAYMENT STATUS WISE POLICY COUNT
SELECT `Payment Status`, COUNT(`Policy ID`) AS Policy_Count FROM payment_history GROUP BY `Payment Status`
ORDER BY Policy_Count DESC;

#10. TOTAL CLAIM AMOUNT
SELECT ROUND(SUM(`Claim Amount`),2) AS Total_Claim_Amount FROM claims;




