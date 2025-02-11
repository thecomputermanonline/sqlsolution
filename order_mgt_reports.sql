--the following scripts is an attempt to query data for the reports (more work needs to be done here expecially in displaying the report but due to time

--REPORT 1
SELECT 
LTRIM(SUBSTR(A.ORDER_REF,4,2), 0) AS ORDERS_REF,
TO_CHAR(A.ORDER_DATE, 'MON-YYYY' ) AS ORDER_PERIOD, 
A.SUPPLY_REF,
A.ORDER_STATUS,
NVL(A.ORDER_TOTAL_AMOUNT,0),
B.INVOICE_AMOUNT,
B.INVOICE_REF,
B.INVOICE_STATUS AS ACTION
FROM XXBCM_ORDERS A
INNER JOIN XXBCM_INVOICES B ON B.ORDER_REF = A.ORDER_REF
ORDER BY A.ORDER_TOTAL_AMOUNT DESC;


--Report 3

SELECT 
COUNT(A.ORDER_REF),
COUNT(A.ORDER_DATE),
TO_CHAR(A.ORDER_DATE, 'MON-YYYY' ) AS ORDER_PERIOD, 
A.SUPPLY_REF,
TO_CHAR(SUM(A.ORDER_TOTAL_AMOUNT) ,'999G999D00'),
REPLACE(regexp_substr(B.SUPP_CONTACT_NUMBER, '[^,]+', 1, 1),' ', '-') AS SUPPLIER_CONTACT_N0_1,
REPLACE(regexp_substr(B.SUPP_CONTACT_NUMBER, '[^,]+', 1, 2),' ', '-') SUPPLIER_CONTACT_N0_2
FROM XXBCM_ORDERS A
INNER JOIN XXBCM_SUPPLIERS B ON B.SUPPLIER_NAME = A.SUPPLY_REF
GROUP BY A.SUPPLY_REF, A.ORDER_REF, A.ORDER_TOTAL_AMOUNT, B.SUPP_CONTACT_NUMBER, A.ORDER_DATE
ORDER BY ORDER_DATE;
