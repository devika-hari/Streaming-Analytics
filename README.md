# 📺 Streaming Analytics – DBT, DuckDB & Python

An end-to-end analytics engineering project built around a fictional video streaming service to analyze key business KPIs:

- **Monthly Revenue**
- **Monthly Active Users (MAU)**

This project demonstrates a complete analytics workflow using:

- Python (data ingestion)
- DuckDB (analytical database)
- SQL (transformations)
- dbt (staging, marts, snapshots, testing, documentation)

All final KPI analysis is derived from:

> `fact_user_monthly_metrics`

---

# 🎯 Business Scenario

We are analyzing a fictional video streaming platform to answer:

- How much **monthly revenue** are we generating?
- How many **monthly active users (MAU)** do we have?

The project models raw data into a clean star schema and produces analytical outputs using dbt best practices.

---

# 🧰 Tools & Technologies

- **Python 3.9+**
- **DuckDB**
- **dbt (DuckDB adapter)**
- **SQL**
- **Snapshots (Slowly Changing Dimensions)**

---

# 🗂 Dataset

The dataset consists of four CSV files located in the `data/` directory:

## `payments.csv`
payment_id, user_id, payment_date, amount


## `subscriptions.csv`


subscription_id, user_id, start_date, end_date, monthly_price


## `users.csv`


user_id, country, signup_date, plan_type


## `viewing_activity.csv`


user_id, watch_date, hours_watched


---

# 🏗 Project Structure

streaming_analytics/

    |--- README.md
    |--- .env
    |--- requirements.txt
    |--- data/
        |--- users.csv
        |--- payments.csv
        |--- subscriptions.csv
        |--- viewing_activity.csv
    |--- code/
        ├── extract.py
    |--- streaming_analytics_dbt/
        |--- dbt_project.yml
        |--- packages.yml
        |--- profiles.yml
        |--- models/
            |--- staging/
                |--- schema.yml
                |--- stg_payments.sql
                |--- stg_subscriptions.sql
                |--- stg_users.sql
                |--- stg_viewing_activity.sql
            |--- marts/
                |--- dim_subscriptions_check.sql
                |--- dim_subscriptions_timestamp.sql
                |--- dim_users.sql
                |--- fact_factless_subscriptions.sql
                |--- fact_user_monthly_metrics.sql
        |--- snapshots/
            |--- subscription_snapshot_check.sql
            |--- subscription_snapshot_timestamp.sql
        |--- analyses/
            |--- monthly_active_users.sql
            |--- monthly_revenue.sql

---

# 🔖 dbt Tags

The project uses tags to enable selective execution:

- `staging`
- `marts`
- `snapshot`

Run specific layers using:

```bash
dbt run --select tag:staging
dbt run --select tag:marts
```
---
# 🚀 How to Run The Project

1️⃣ Clone the Repository
git clone <your-repository-url>
cd streaming_analytics

2️⃣ Install Python Dependencies
pip install -r requirements.txt


Ensure you have:

- Python 3.9+
- DuckDB installed
- dbt-duckdb adapter configured

3️⃣ Configure Environment Variables

Create a .env file in the project root:

DB_PATH=your_database.duckdb
DATA_DIR=./data


DB_PATH → DuckDB database file

DATA_DIR → Path to CSV files

4️⃣ Load Raw Data into DuckDB
python project_code/extract.py


This will:

- Create a raw schema

- Load CSV files into:

  - raw.users_raw
  - raw.payments_raw
  - raw.subscriptions_raw
  - raw.viewing_activity_raw

5️⃣ Install dbt Packages:
dbt deps

6️⃣ Run Full dbt Pipeline:
dbt build


This runs:

- Models (staging + marts)

- Tests

- Snapshots

📊 Final Analytical Output

All KPI analysis is derived from:

- fact_user_monthly_metrics: It serves as the single source of truth for reporting.


This table provides:

- Monthly Active Users (MAU)

- Monthly Revenue


🕒 Snapshots (SCD Implementation)

Two snapshot strategies are implemented:

1️⃣ Check Strategy

Tracks changes by comparing column values.

2️⃣ Timestamp Strategy

Tracks changes using a timestamp column.

These demonstrate alternative Slowly Changing Dimension (SCD) modeling techniques.

**Run snapshots manually:**

    dbt snapshot

📚 **Generate dbt Documentation**

Generate documentation:

    dbt docs generate


Serve locally:

    dbt docs serve

🧹 Clean Project (When Needed)

If you need to remove compiled artifacts:

    dbt clean


Use this when:

- Target folder becomes corrupted

- You want a clean rebuild

🔁 Typical Execution Flow
- git clone <repo>
-  cd streaming_analytics
  - pip install -r project_code/requirements.txt
  - python project_code/extract.py


    dbt deps
    dbt build

    dbt docs generate
    dbt docs serve

🧠 Design Principles

- All business logic resides inside dbt models

- Clear separation between staging and marts

- Tag-based execution for modular runs

- Snapshot implementation for SCD demonstration

- Analytics derived from a single fact table for clarity

🔮 Future Enhancements

- Airflow orchestration
- Additional KPIs
- Data quality monitoring
- CI/CD integration for dbt
- BI tool integration