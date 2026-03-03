# 🎵 iTunes Analytics Engineering Project

## 🚀 Overview

This project implements a production-style analytics pipeline on the Apple iTunes dataset using **dbt and BigQuery**.

The objective is to transform raw relational data into an analytics-ready warehouse using dimensional modeling principles to enable reliable insights into customer behavior, sales performance, and music trends.

The architecture follows a layered ELT approach:

Raw → Staging → Core (Dimensional Model) → Marts

---

## 🏗 Architecture

### 🔹 Staging Layer
Responsible for:
- Data type standardization
- Column renaming & trimming
- Timestamp parsing
- Grain alignment
- Source normalization
- Basic data validation

Data quality tests applied:
- `not_null`
- `unique`
- `unique_combination_of_columns`
- `relationships`
- Expression checks (e.g., numeric fields >= 0)

---

### 🔹 Core Layer (Dimensional Model)

Star schema implementation with clear grain discipline.

#### 🧾 Fact Table
- `fact_invoice_line` (Atomic grain: invoice line level)

#### 📐 Dimension Tables
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

#### 🔗 Bridge Tables (Many-to-Many Modeling)
- `bridge_playlist_tracks`
- `bridge_track_composer`

Key modeling principles:
- Atomic fact design
- Surrogate key strategy
- Referential integrity enforcement
- Separation of staging and business logic
- Conformed dimensions across models

---

## 📊 Marts Layer (Business-Facing Models)

The following analytical marts were built:

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

## 🔁 Incremental & Temporal Strategy

The project incorporates:

- Incremental modeling patterns
- SCD (Type 1 & Type 2) design readiness
- Surrogate key determinism
- Late arriving data considerations
- Merge-based update strategy (BigQuery compatible)

---

## 🧪 Data Quality & Governance

Data quality enforcement includes:

- Primary key validation
- Grain enforcement
- Relationship integrity checks
- Business rule constraints
- Controlled transformation layering

This ensures reliable downstream analytics and metric consistency.

---

## 🛠 Tech Stack

- **BigQuery** (Cloud Data Warehouse)
- **dbt** (Data Transformation & Modeling)
- SQL
- Git (Version Control)

---

## 🎯 Business Objectives

The warehouse enables analysis of:

- Customer purchasing behavior
- Revenue performance
- Artist and genre popularity
- Country-level purchasing patterns
- Playlist composition trends
- Employee sales performance

---

## 🧠 Key Concepts Applied

- Dimensional Modeling
- Star Schema Architecture
- Fact & Dimension Separation
- Bridge Tables for Many-to-Many Relationships
- Surrogate Key Strategy
- Layered Warehouse Architecture
- ELT Paradigm
- Data Quality Testing in dbt

---

## 🔮 Future Enhancements

- Full production-grade SCD Type 2 implementation
- Cost-aware partitioning & clustering optimization
- CI/CD integration for dbt workflows
- Performance benchmarking & scan optimization
- Environment separation (dev / prod)

---

## 📌 Summary

This project demonstrates enterprise-style analytics engineering practices focused on semantic clarity, model integrity, and scalable warehouse design using modern ELT principles.