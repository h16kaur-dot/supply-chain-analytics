# Supply Chain & Logistics Analytics

An end-to-end data analytics project on a real-world supply chain dataset
of 180,000+ records, built as a placement portfolio project.

## Project Overview

This project analyzes supply chain and logistics data to uncover insights
on sales performance, delivery efficiency, and demand forecasting. The
project covers the full data analytics pipeline — from raw data cleaning
to an interactive business dashboard.

## Tools and Technologies

- Python (Pandas, Matplotlib, Seaborn, Prophet)
- SQL (MySQL Workbench)
- Power BI Desktop

## Project Structure

supply_chain_analysis/
├── data/
│   ├── raw/                        # Original dataset
│   └── cleaned/                    # Cleaned and processed CSVs
├── visuals/                        # EDA charts exported from Python
├── notebook1_data_cleaning.ipynb   # Data cleaning and preprocessing
├── notebook2_eda.ipynb             # Exploratory data analysis
├── notebook3_forecasting.ipynb     # Demand forecasting using Prophet
├── supply_chain_dashboard.pbix     # Power BI dashboard file
└── README.md

## Dataset

- Source: DataCo Supply Chain Dataset
- Size: 180,519 rows, 51 columns
- Domain: E-commerce supply chain and logistics

## Python Analysis

- Cleaned and preprocessed raw data (handled nulls, duplicates, dtypes)
- Performed exploratory data analysis with 5 visualizations
- Built a demand forecasting model using Facebook Prophet
- Exported forecast results with predicted orders, upper and lower bounds

## SQL Analysis

10 business queries written and executed in MySQL Workbench covering:
- Top selling product categories and departments
- Regional sales performance
- Late delivery rate by region and shipping mode
- Monthly revenue trends
- Customer segment analysis

## Power BI Dashboard

3-page interactive dashboard built on cleaned data:

- Sales Overview: KPI cards for total sales, orders and delivery days,
  bar chart by category, donut chart by market, line chart for sales
  trend, and world map by country
- Demand Forecast: Line chart showing predicted orders over time with
  a total forecast KPI card
- Delivery Analysis: Bar chart of delivery days by region, donut chart
  of delivery status distribution, average shipping days KPI card

## Key Findings

- Fishing is the highest revenue category at 6.9M in total sales
- LATAM and Europe are the top performing markets by revenue
- Significant delivery delays observed in specific regions
- Demand forecasting model successfully predicts future order volumes

## How to Run

1. Open notebooks in Jupyter in order (notebook1, notebook2, notebook3)
2. Ensure dataset is placed in data/raw/ folder
3. Open supply_chain_dashboard.pbix in Power BI Desktop
