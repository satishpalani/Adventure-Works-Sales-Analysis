# Adventure Works Sales Analysis & BI

End-to-end sales analysis of the Adventure Works dataset, built **independently in four tools**: MySQL, Excel, Power BI and Tableau. The aim was to take the same raw data and produce the same business answers in each tool: total sales, production cost, profit and margin, broken down by time, product, customer and region.

## Business Questions

- How much did we sell, what did it cost to produce, and what was the profit and margin?
- How do sales trend by year, quarter and month?
- Which products and customers drive the most sales?
- Which sales territories perform best?

## Headline Numbers

| KPI | Value |
|---|---|
| Total Sales | $29.36M |
| Production Cost | $17.28M |
| Total Profit | $12.08M |
| Profit Margin | ~41% |

- Sales are highest in **Q4 (Oct–Dec)**, with **December** the strongest month at about $3.21M.
- Sales are lowest in **February** at about $1.74M.

## Tools & Skills

| Tool | What I did |
|---|---|
| **MySQL** | Combined tables with `UNION ALL`, joined dimension tables, built date and financial calendar fields, calculated sales, cost and profit |
| **Excel** | Power Query for cleaning and merging, Power Pivot data model, pivot tables, interactive dashboard with slicers |
| **Power BI** | Data model, DAX measures, 9-page report including a summary dashboard |
| **Tableau** | 13 worksheets (KPIs, trends, Top 10s, region) combined into a dashboard |

## Dataset

- Fact tables: `FactInternetSales` and `Fact_Internet_Sales_New`, combined into one sales table
- Dimension tables: `DimProduct`, `DimCustomer`, and sales territory data
- About 60K order lines in the combined table

## Data Preparation (applied in every tool)

1. **Appended** the two fact tables into one sales table.
2. **Product lookup**: added product name using `ProductKey`.
3. **Customer lookup**: added full customer name (first + middle + last) and unit price using `CustomerKey`.
4. **Date fields** derived from `OrderDateKey`: Year, Month No., Month Name, Quarter, Year-Month, Weekday No., Weekday Name, Financial Month and Financial Quarter (financial year starts in April).
5. **Calculated columns**:
   - `Sales Amount = UnitPrice × OrderQuantity × (1 − Discount%)`
   - `Production Cost = ProductStandardCost × OrderQuantity`
   - `Profit = Sales Amount − Production Cost`

## Dashboards & Visuals

- KPI cards: Total Sales, Production Cost, Profit, Profit Margin
- Sales by Year, Quarter and Month
- Top 10 Products by Sales
- Top 10 Customers by Sales
- Sales by Region

  ## Key Insights
- Total sales of about $29.36M, with a profit of $12.08M (41.15% profit margin)
- Australia is the top region, contributing 30.9% of total sales, followed by Southwest (19.5%) and Northwest (12.4%)
- The Mountain-200 bike range dominates product sales. The top product is Mountain-200 Black, 46, at about $1.37M
- Sales peak in Q4 (31% of the total), with December the strongest month
- 2013 was the highest sales year, with 55.7% of total sales

## Dashboard Screenshots
### Power BI
![Power BI Dashboard](AdventureWorks-PowerBI_Dashboard.jpeg)

### Tableau
![Tableau Dashboard](AdventureWorks-Tableau_Dashboard.png)

### Excel
![Excel Dashboard](AdventureWorks-Excel_Dashboard.png)


## Key Learnings

- Rebuilding the same analysis in four tools showed how the same logic (joins, calculated fields, aggregations) is written differently in SQL, DAX, Excel formulas and Tableau calculations.
- Cross-checking totals between tools was an effective way to catch errors.

## About Me

**Satish Palani**, Bangalore. HR operations professional moving into data analytics.
[[LinkedIn](https://www.linkedin.com/in/satish-palani-9816021a3)] | [satish.pkjh@gmail.com]

*Related project: [Insurance Analytics](https://github.com/satishpalani/Insurance-Analytics) – Weekly Branch Dashboard.*
