/* Generic SQL Server load template.
   Adapt column mapping to the approved Emmtec ERP/CRM export.
   Never commit confidential source extracts to this public repository.
*/

-- Example staging pattern:
-- BULK INSERT analytics.fact_sales
-- FROM 'C:\approved\emmtec_sales.csv'
-- WITH (FORMAT='CSV', FIRSTROW=2, FIELDQUOTE='"', TABLOCK);

-- Production recommendation:
-- 1. Land source file in Bronze.
-- 2. Validate schema and row-level quality.
-- 3. MERGE valid rows into FactSales using source row/business key.
-- 4. Reconcile totals to source control totals.
-- 5. Refresh semantic model only after reconciliation passes.

SELECT 'Configure approved source mapping before production load' AS instruction;
