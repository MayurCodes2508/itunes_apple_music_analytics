# 🎵 iTunes Analytics Engineering Project

## 🚀 Overview

This project implements a **production-style analytics engineering pipeline** on the Apple iTunes dataset using **dbt and Google BigQuery**.

The goal of this project is to transform raw relational datasets into an **analytics-ready warehouse** using dimensional modeling principles, enabling reliable insights into customer behavior, sales performance, and music consumption trends.

The warehouse architecture follows a modern **ELT layered design**:

Raw → Staging → Core (Dimensional Model) → Marts

This project demonstrates **real-world analytics engineering practices including dimensional modeling, data quality testing, SCD handling, incremental modeling, and warehouse optimization.**

---

# 📈 Project Metrics

| Component | Count |
|----------|------|
| Models | 38 |
| Seeds | 11 |
| Sources | 11 |
| Data Tests | 119 |
| Snapshots | 1 |
| Warehouse | BigQuery |
| Transformation Tool | dbt |

The project contains **extensive automated data validation and production-style modeling patterns.**

---

# 🏗 Architecture

## 🔹 Raw Layer

Raw datasets are ingested into the warehouse using **dbt seeds**.

This layer acts as the **initial landing zone** for source data before any transformation or validation occurs.

---

## 🔹 Staging Layer

The staging layer prepares raw data for downstream analytical modeling.

Responsibilities include:

- Data type standardization
- Column renaming and trimming
- Timestamp normalization
- Grain alignment
- Source data cleaning
- Initial data validation

This layer ensures **data inconsistencies are handled early before propagating into the warehouse models.**

---

# 🔹 Core Layer (Dimensional Model)

The core layer implements a **star schema** designed for analytical workloads.

This layer enforces:

- Dimensional modeling rules
- Surrogate key generation
- Referential integrity
- Business logic implementation
- Many-to-many relationship resolution

---

## 🧾 Fact Table

### `fact_invoice_line`

Grain:

Invoice Line Level (Atomic Transaction Grain)

Key metrics:

- Quantity purchased
- Unit price
- Total revenue

The fact table is implemented using **incremental materialization and clustering optimization** for efficient warehouse processing.

---

## 📐 Dimension Tables

- `dim_customer_current`
- `dim_customer_history` (SCD Type 2)
- `dim_employee`
- `dim_track`
- `dim_album`
- `dim_genre`
- `dim_media_type`
- `dim_playlist`
- `dim_composer`
- `dim_date`
- `dim_invoice`

### Customer Dimension Strategy

Customer data is implemented using **Slowly Changing Dimension Type 2**.

Structure:

snapshot_customer → dim_customer_history → dim_customer_current

This allows:

- Historical customer tracking
- Current customer dimension for analytics joins
- Proper temporal modeling

---

## 🔗 Bridge Tables (Many-to-Many Modeling)

Many-to-many relationships are resolved using bridge tables:

- `bridge_playlist_track`
- `bridge_track_composer`

Examples:

Tracks ↔ Playlists  
Tracks ↔ Composers

This preserves **correct dimensional grain while enabling flexible analytics queries.**

---

# 🧪 Data Quality & Testing

The project implements **119 automated data tests** across staging and core layers using **dbt**.

### Structural Integrity

- `not_null`
- `unique`

### Referential Integrity

- `relationships` tests ensuring valid foreign key dependencies

### Grain Enforcement

- `unique_combination_of_columns` tests for bridge tables

### Business Rule Validation

Expression tests such as:

- `quantity >= 0`
- `unit_price >= 0`
- `total_revenue >= 0`
- `milliseconds >= 0`

These tests guarantee:

- Data integrity
- Correct dimensional grain
- Protection against upstream data issues

---

# 🔁 Temporal Modeling & Incremental Strategy

The warehouse includes production-ready temporal modeling patterns.

### Snapshot (SCD Type 2)

Customer dimension history is maintained using **dbt snapshots**.

This enables:

- Historical tracking of customer attribute changes
- Slowly changing dimension modeling

---

### Incremental Fact Processing

The `fact_invoice_line` table uses **incremental materialization** with:

- `merge` strategy
- late arriving data handling
- cluster optimization

This reduces warehouse compute cost and improves runtime performance.

---

# ⚡ Warehouse Optimization

Query performance optimization techniques include:

### Clustering

Fact table clustering:

- `customer_key`
- `track_key`

Benefits:

- Reduced query scan size
- Faster analytical queries

---

### Incremental Models

Only new or updated records are processed during pipeline runs.

Benefits:

- Reduced compute cost
- Faster pipeline execution

---

# 📊 Marts Layer (Business-Facing Models)

The marts layer exposes curated analytical datasets used for reporting and insights.

Implemented marts include:

- `mart_avg_prices_of_different_types_of_music`
- `mart_best_customer`
- `mart_city_having_best_customer`
- `mart_countries_having_the_most_invoices`
- `mart_customer_amount_spent_on_artist`
- `mart_customer_name_genre_and_email_starting_with_a`
- `mart_most_popular_artists`
- `mart_most_popular_countries_for_music_purchases`
- `mart_most_popular_genre_for_each_country`
- `mart_most_popular_song`
- `mart_senior_most_employee_based_on_job_title`
- `mart_top_3_values_of_total_invoice`
- `mart_top_10_rock_bands`
- `mart_top_customers_spent_most_money_for_each_country`
- `mart_tracks_with_song_length_longer_than_avg_length`

These marts enable analysis of:

- Revenue performance
- Customer segmentation
- Artist popularity
- Geographic music trends
- Playlist behavior
- Employee sales performance

---

# 📂 Project Structure

```
models/
│
├── staging
│   └── Data cleaning and normalization
│
├── intermediate
│   └── Preprocessing logic
│
├── core
│   ├── dimensions
│   ├── facts
│   └── bridges
│
└── marts
    └── Business analytical datasets
```

This layered design ensures:

- Clear transformation boundaries
- Maintainable warehouse logic
- Scalable analytics pipelines

---

# 🛠 Tech Stack

- **BigQuery** — Cloud Data Warehouse  
- **dbt** — Data Transformation Framework  
- **SQL**  
- **Git** — Version Control  

---

# ▶️ Running the Project

### Install dependencies

```
pip install dbt-bigquery
```

### Load raw datasets

```
dbt seed
```

### Build models

```
dbt run
```

### Run tests

```
dbt test
```

### Generate documentation

```
dbt docs generate
dbt docs serve
```

---

# 🎯 Business Questions Answered

The warehouse enables analysis of:

- Who are the highest spending customers?
- Which genres generate the most revenue?
- What countries purchase the most music?
- Which artists are most popular?
- What tracks exceed average song length?
- Which employees generate the highest sales?

---

# 🧠 Key Concepts Applied

- Dimensional Modeling
- Star Schema Design
- Slowly Changing Dimensions (SCD Type 2)
- Incremental Fact Processing
- Bridge Tables for Many-to-Many Relationships
- Surrogate Key Strategy
- Layered ELT Architecture
- Automated Data Testing
- Query Optimization (Clustering)

---

# 🔮 Future Enhancements

Potential improvements:

- Partitioned fact tables
- Advanced cost monitoring
- CI/CD pipelines for dbt deployment
- Data freshness monitoring
- Production orchestration integration

---

# 📌 Summary

This project demonstrates **production-grade analytics engineering practices** including dimensional modeling, temporal data management, incremental processing, and automated data quality enforcement.

The warehouse architecture prioritizes **semantic clarity, scalable transformations, and reliable analytical outputs.**