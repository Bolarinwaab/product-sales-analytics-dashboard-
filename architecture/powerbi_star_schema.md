# Power BI Semantic Model — EMMTEC Sales

## Model

**FactSales** is the central transaction fact at one row per order line.

| Table | Key | Important attributes |
|---|---|---|
| FactSales | SalesLineKey | OrderID, DateKey, CustomerKey, ProductKey, GeographyKey, ShippingKey, Sales, Quantity, Discount, Profit |
| DimDate | DateKey | Date, Year, Quarter, Month, MonthName, Week |
| DimCustomer | CustomerKey | CustomerID, CustomerName, Segment |
| DimProduct | ProductKey | ProductID, ProductName, Category, SubCategory |
| DimGeography | GeographyKey | Country, Region, State, City, PostalCode |
| DimShipping | ShippingKey | ShipMode, OrderPriority |
| DimDiscount | DiscountKey | DiscountBand, DiscountRate |

## Relationships

All dimensions filter FactSales through one-to-many relationships using surrogate integer keys. Keep filter direction single-direction unless a documented exception exists.

Order Date is the primary date relationship. Ship Date should be modeled as a separate role-playing date table or carefully managed inactive relationship depending on report requirements.

This follows Microsoft's recommended star-schema approach for Power BI semantic models. citeturn0search0turn0search3

## Core DAX measures

```DAX
Revenue = SUM(FactSales[Sales])

Profit = SUM(FactSales[Profit])

Units Sold = SUM(FactSales[Quantity])

Orders = DISTINCTCOUNT(FactSales[OrderID])

Customers = DISTINCTCOUNT(FactSales[CustomerKey])

Profit Margin = DIVIDE([Profit], [Revenue])

Revenue PY = CALCULATE([Revenue], DATEADD(DimDate[Date], -1, YEAR))

Revenue YoY % = DIVIDE([Revenue] - [Revenue PY], [Revenue PY])

Profit PY = CALCULATE([Profit], DATEADD(DimDate[Date], -1, YEAR))

Profit YoY % = DIVIDE([Profit] - [Profit PY], [Profit PY])

Units PY = CALCULATE([Units Sold], DATEADD(DimDate[Date], -1, YEAR))

Units YoY % = DIVIDE([Units Sold] - [Units PY], [Units PY])

Average Order Value = DIVIDE([Revenue], [Orders])

Revenue per Customer = DIVIDE([Revenue], [Customers])
```

## Executive pages

1. **Executive Overview** — KPI cards, revenue trend, profit trend, country ranking.
2. **Geography** — country/region performance and map.
3. **Commercial Performance** — products, categories, segments and discount bands.
4. **Operations** — shipping mode, delivery time and priority.
5. **Management Scorecard** — Country × Year with revenue, profit, margin, units and YoY.

## RLS design

Where business ownership requires restricted views, create a security mapping table:

`UserPrincipalName → Country/Region → DimGeography`

Apply RLS at the geography dimension rather than directly on FactSales.
