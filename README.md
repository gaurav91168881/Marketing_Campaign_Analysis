# Marketing Campaign Analysis

**Domain:** Marketing  
**Tools:** MySQL, Power BI  

## Overview

This project turns fragmented customer, engagement, and journey data into a single, data-driven view of marketing campaign performance. It combines SQL-based data modeling and analysis with an interactive Power BI dashboard to help stakeholders understand customer behavior, campaign effectiveness, and product performance.

**Objectives**
- Analyze customer engagement across multiple marketing campaigns
- Identify top-performing countries, campaigns, and products
- Provide actionable insights for marketing decisions

## Project Workflow

1. Collected and explored marketing data
2. Cleaned and transformed data using SQL
3. Performed customer segmentation and KPI analysis
4. Built an interactive Power BI dashboard
5. Generated business insights and recommendations

## Repository Contents

| File | Description |
|---|---|
| `MCA.sql` | Database schema, table creation, data validation, and analytical queries |
| `MCA.pbix` | Power BI dashboard file with interactive visuals |
| `MCA.pptx` | Project presentation summarizing approach, insights, and recommendations |

## Data Model

The database (`marketing_campaign_analysis`) consists of six tables:

| Table | Purpose |
|---|---|
| `Countries` | Country and city reference data |
| `Customers` | Customer demographics (name, email, gender, age, location) |
| `Products` | Product catalog with category and price |
| `Customer_Journey` | Customer touchpoints across journey stages (e.g., checkout), with actions and duration |
| `Cust_Review` | Customer product reviews and ratings |
| `Engagement_Data` | Content engagement metrics (likes, views/clicks) tied to campaigns and products |

Each table uses a primary key, so the dataset contains no duplicate records.

## SQL Analysis

The `MCA.sql` script covers:

- **Data validation:** row counts, schema checks (`DESC`), and duplicate detection
- **Customer segmentation:** classifying customers as Young (<30), Adult (30–50), or Senior (>50)
- **Average rating by segment:** comparing satisfaction across age groups
- **Top 5 countries by average rating:** identifying the happiest customer markets
- **Inactive customer check:** customers with no submitted reviews
- **Engagement vs. rating comparison:** whether higher-engagement products earn higher ratings
- **Checkout completion vs. rating:** whether completing checkout correlates with higher satisfaction
- **Average journey duration per customer**

### Key SQL Findings

- **Adult** customers give the highest average ratings, suggesting campaigns should continue targeting this segment while working to improve satisfaction among Young and Senior segments.
- The top 5 countries by average rating represent markets where customer satisfaction strategies are working well and could be replicated elsewhere.
- **No inactive customers** were found — every customer has submitted at least one review.
- Products with higher engagement tend to maintain higher customer ratings.
- Checkout completion showed **no meaningful difference** in ratings (3.69 vs. 3.68 average), indicating similar satisfaction regardless of checkout completion.

## Power BI Dashboard

The dashboard (`MCA.pbix`) provides an interactive view of:

- Customer distribution
- Campaign performance
- Content engagement
- Product ratings
- Customer segmentation
- Country-wise performance
- Customer reviews

### Screenshots

<img width="1377" height="772" alt="1" src="https://github.com/user-attachments/assets/cdf1c239-229f-4c49-b051-04b905611252" />

<img width="1377" height="772" alt="2" src="https://github.com/user-attachments/assets/361021ba-8a7d-47f7-8b4e-f0d25028b24c" />

<img width="1376" height="777" alt="3" src="https://github.com/user-attachments/assets/bf670bf4-c7a8-41cb-8609-676d33cf38ef" />


## Key Insights

| Metric | Result |
|---|---|
| Highest customer base | Spain |
| Best performing campaign | Campaign 15 |
| Most engaging content type | Blog (142k likes) |
| Highest-rated customer segment | Senior |
| Country with happiest customers | Spain |
| Top-rated products | Climbing Ropes, Swim Goggles, Cycling Helmet |

## Recommendations

- Invest more in successful campaigns.
- Target high-performing regions.
- Promote top-rated products.
- Improve engagement among inactive/low-engagement customers.

## Conclusion

This project processed and analyzed marketing data using SQL, developed an interactive Power BI dashboard, identified key trends in customer behavior and campaign performance, and delivered actionable insights to support marketing decision-making.

**Skills Demonstrated:** SQL · Power BI · Data Analysis · Dashboard Development · Business Intelligence

## How to Use

1. **Database setup:** Run `MCA.sql` in MySQL to create the `marketing_campaign_analysis` database, tables, and run the analytical queries.
2. **Dashboard:** Open `MCA.pbix` in Power BI Desktop to explore the interactive visuals (connect it to your populated database if the data source needs to be refreshed).
3. **Presentation:** Review `MCA.pptx` for a summarized walkthrough of the project, methodology, and findings.
