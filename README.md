# 🎵 iTunes Analytics Engineering Project

## 🚀 Overview

This project implements a production-style analytics pipeline on the Apple iTunes dataset using **dbt and BigQuery**.

The objective is to transform raw relational data into an analytics-ready warehouse using dimensional modeling principles to enable reliable insights into customer behavior, sales performance, and music trends.

The architecture follows a layered ELT approach:

Raw → Staging → Core (Dimensional Model) → Marts

---

# 📈 Project Metrics

| Component | Count |
|----------|------|
| Models | 37 |
| Seeds | 11 |
| Sources | 11 |
| Data Tests | 108 |
| Warehouse | BigQuery |
| Transformation Tool | dbt |

This project includes **extensive automated testing and dimensional modeling practices**, reflecting production-style analytics engineering workflows.

---

# 🏗 Architecture

## 🔹 Raw Layer

Raw datasets are ingested into the warehouse using **dbt seeds**.

This layer represents the landing zone of source data before any transformation or validation occurs.

---

## 🔹 Staging Layer

Responsible for preparing raw data for downstream modeling.

Key responsibilities include:

- Data type standardization
- Column renaming and trimming
- Timestamp parsing and normalization
- Grain alignment
- Source normalization
- Initial data validation

The staging layer ensures that **raw ingestion issues are caught early before propagating into analytical models**.

---

# 🔹 Core Layer (Dimensional Model)

The core layer implements a **star schema** designed for analytical workloads.

This layer enforces:

- Business logic
- Dimensional modeling rules
- Referential integrity
- Surrogate key strategy

---

## 🧾 Fact Table

### `fact_invoice_line`

Grain:

```
Invoice Line Level (Atomic Fact)
```

---

## 📐 Dimension Tables

- `dim_customer`
- `dim_employee`
- `dim_track`
- `dim_album`
- `dim_genre`
- `dim_media_type`
- `dim_playlist`
- `dim_composer`
- `dim_date`
- `dim_invoice`

---

## 🔗 Bridge Tables (Many-to-Many Modeling)

- `bridge_playlist_tracks`
- `bridge_track_composer`

These resolve many-to-many relationships between entities such as:

- Tracks ↔ Playlists
- Tracks ↔ Composers

---

### Core Modeling Principles

- Atomic fact table design
- Deterministic surrogate key generation
- Dimension conformance
- Referential integrity across fact and dimensions
- Separation of staging and business logic

---

# 🧪 Data Quality & Testing

The project implements **108 automated data tests** across staging and core layers using **dbt**.

### Structural Integrity

- `not_null` tests
- `unique` tests

### Referential Integrity

- `relationships` tests ensuring fact-to-dimension dependencies

### Grain Enforcement

- `unique_combination_of_columns` tests for bridge tables

### Business Rule Validation

Expression tests including:

- `quantity >= 0`
- `unit_price >= 0`
- `total_revenue >= 0`
- `milliseconds >= 0`

These tests ensure **data reliability, model correctness, and protection against upstream data issues**.

---

# 📊 Marts Layer (Business-Facing Models)

The marts layer exposes curated analytical datasets for business analysis.

Implemented marts include:

- `mart_avg_prices_of_different_types_of_music`
- `mart_best_customers`
- `mart_city_having_best_customer`
- `mart_countries_having_the_most_invoices`
- `mart_customer_amount_spent_on_artists`
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

These marts enable:

- Revenue analysis
- Customer segmentation
- Genre and artist trend identification
- Geographic sales insights
- Operational employee performance evaluation

---

# 📂 Project Structure

```
models/
│
├── staging
│   └── Source standardization & data cleaning
│
├── intermediate
│   └── Data normalization & preprocessing logic
│
├── core
│   ├── dimensions
│   │   └── Conformed dimension models
│   │
│   ├── facts
│   │   └── Atomic transactional fact tables
│   │
│   └── bridges
│       └── Many-to-many relationship resolution
│
└── marts
    └── Business-facing analytical datasets
```

This layered structure enforces **clear separation between raw data preparation, business logic modeling, and analytical consumption layers**.

---

# 🔁 Incremental & Temporal Strategy

The warehouse design supports production-ready temporal modeling patterns including:

- Incremental modeling patterns
- SCD Type 1 / Type 2 readiness
- Surrogate key determinism
- Late arriving data considerations
- Merge-based update strategy compatible with BigQuery

---

# 🛠 Tech Stack

- **BigQuery** — Cloud Data Warehouse
- **dbt** — Data Transformation & Modeling
- **SQL**
- **Git** — Version Control

---

# ▶️ Running the Project

To reproduce the warehouse pipeline:

### Install dependencies

```
pip install dbt-bigquery
```

### Load raw datasets

```
dbt seed
```

### Build the warehouse models

```
dbt run
```

### Run data quality tests

```
dbt test
```

### Generate documentation

```
dbt docs generate
dbt docs serve
```

---

# 🎯 Business Objectives

The warehouse enables analysis of:

- Customer purchasing behavior
- Revenue performance
- Artist and genre popularity
- Country-level purchasing patterns
- Playlist composition trends
- Employee sales performance

---

# 🧠 Key Concepts Applied

- Dimensional Modeling
- Star Schema Architecture
- Fact & Dimension Separation
- Bridge Tables for Many-to-Many Relationships
- Surrogate Key Strategy
- Layered Warehouse Architecture
- ELT Paradigm
- Data Quality Testing with dbt
- Referential Integrity Enforcement

---

# 🔮 Future Enhancements

Planned improvements include:

- Production-grade SCD Type 2 implementation
- Cost-aware partitioning and clustering strategies
- CI/CD pipeline integration for dbt deployments
- Query scan optimization and cost monitoring
- Environment separation (dev / prod)

---

# 📌 Summary

This project demonstrates enterprise-style analytics engineering practices focused on semantic clarity, dimensional integrity, and scalable warehouse design using modern ELT principles.

The implementation emphasizes **robust data quality validation, layered modeling architecture, and production-ready analytical design**.