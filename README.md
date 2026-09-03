# CleverTap Data Export & Analysis Pipeline

This repository documents the process for exporting event data from **CleverTap**, storing it in **AWS S3**, creating structured raw tables, and transforming the data into clean views for analysis.

The pipeline provides a flexible alternative to CleverTap's built-in BI capabilities while continuing to use CleverTap as the primary event collection platform.

---

## Overview

The data flow is:

```text
CleverTap
    │
    │ Export Events
    ▼
AWS S3
    │
    │ Parquet Files
    ▼
Raw Tables
    │
    │ Transform / Clean
    ▼
Clean Views
    │
    ├──► Analysis
    │
    └──► S3 Backup (Optional)
```

---

## Data Export & Processing Steps

### 1. Export Data from CleverTap

Use the **CleverTap Export Center** to create an export.

Configure the export with:

* **S3 Bucket:** `clevertap-prod-export`
* **Format:** Parquet
* **Compression:** No gzip
* **Folder structure:** Separate sub-folders for each event

For example:

```text
clevertap-prod-export/
├── app_launch/
├── login_started/
├── login_ended/
├── session_start/
├── match_start/
├── match_end/
└── ...
```

---

### 2. Verify Data in AWS S3

After configuring the export, verify that data is successfully flowing into the S3 bucket.

Check:

* Whether new files are being created
* Whether the expected event folders are receiving data
* Whether the files contain the expected date/time range
* Whether the export is complete and consistent

---

### 3. Identify the Parquet Schema

Inspect the exported Parquet files to determine the column schema for each event.

The schema should be used as the source of truth when creating the corresponding raw tables.

> **Important:** The schema can change when new events or parameters are introduced or existing events are modified.

---

### 4. Create Raw Tables

Create raw tables based on the schema identified from the Parquet files.

The raw tables should closely represent the structure of the exported CleverTap data without applying significant transformations.

A sample table-creation query is available in the repository.

Example conceptual structure:

```text
CleverTap Parquet
       │
       ▼
   Raw Table
       │
       │ Minimal transformation
       ▼
   Clean View
```

---

### 5. Create Clean Views

Build clean views on top of the raw tables.

The clean views are responsible for:

* Transforming raw data into an analysis-friendly structure
* Standardizing fields
* Applying required data transformations
* Making event data easier to query
* Providing a consistent layer for analysis

The **clean view should be treated as the primary layer for analysis** rather than querying the raw tables directly.

---

### 6. Export Clean Views to S3 — Optional

Clean views can optionally be exported to S3.

This can be useful for:

* Backups
* Snapshots
* Downstream processing
* Sharing data with other systems
* Maintaining historical copies of transformed data

This step is optional and is not required for analysis.

---

### 7. Analyse the Data

Use the **clean views** as the primary source for analysis.

This allows for more flexible and complex analysis than what is available through CleverTap's native BI functionality.

---

# Events Implemented

The following CleverTap events are currently implemented:

### Authentication & Onboarding

* `app_launch`
* `login_started`
* `login_ended`
* `tos_view`
* `tos_accept`
* `ftue`

### Gameplay

* `bat_result`
* `ball_result`
* `session_start`
* `pack_open_completed`

### Matchmaking & Matches

* `matchmaking_started`
* `matchmaking_ended`
* `match_start`
* `match_end`

### Errors

* `network_error`

### Other

* Task-system-related events

---

# What This Enables

## Flexible Analysis

CleverTap's built-in BI capabilities are relatively limited when it comes to flexible and complex analysis.

This pipeline allows us to:

* Query the underlying event data directly
* Perform complex SQL analysis
* Join CleverTap events with other datasets
* Build custom metrics and KPIs
* Create reusable analytical views
* Perform analysis that is difficult or impractical within CleverTap

At the same time, CleverTap can continue to be used for **event collection and instrumentation**.

---

## Interim Data Engineering Solution

This pipeline can serve as a reliable interim solution until an in-house data engineering team and broader data infrastructure are in place.

It provides a structured path from:

**Event Collection → Storage → Transformation → Analysis**

without requiring CleverTap's BI layer to be the primary analytical system.

---

# Limitations

## 1. Schema Changes Require Manual Updates

Adding new events or parameters, or modifying existing events, can change the underlying schema.

As a result, manual effort is required to:

1. Identify the schema change
2. Update the raw table
3. Update the clean view
4. Validate the resulting data

This is not unique to CleverTap. Similar schema-management work would also be required with an in-house event/data engineering pipeline.

---

## 2. Existing CleverTap Data Accuracy Issues

Some existing data accuracy issues in CleverTap will continue to persist in this pipeline because the pipeline relies on CleverTap as the source of event data.

For example, the backend team has reported that the number of multiplayer sessions available in CleverTap is lower than the number reported by the backend.

The current discrepancy is considered tolerable at **less than 5%**, but the data loss will continue to be reflected in this pipeline until the underlying issue is resolved.

---

## 3. Player Identity Before Login

Player identity is established only after a successful login.

If a player drops off before login succeeds:

* We cannot determine whether the player is new or existing
* The same individual may contribute to the apparent user count without being identifiable
* We cannot reliably diagnose the user's journey because their identity is unavailable

This limitation is primarily dependent on **when and how player identity is established** and is not necessarily specific to CleverTap.

---

# Recommended Data Architecture

The recommended architecture is:

```text
┌──────────────────────┐
│      CleverTap       │
│   Event Collection   │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│       AWS S3         │
│   Parquet Exports    │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│      Raw Tables      │
│  Source-aligned data │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│     Clean Views      │
│ Transformed & clean  │
│   analytical layer   │
└──────────┬───────────┘
           │
           ├───────────────┐
           ▼               ▼
     ┌───────────┐   ┌──────────────┐
     │ Analysis  │   │ S3 Snapshot  │
     └───────────┘   │   (Optional) │
                     └──────────────┘
```

---

# Future Tasks

## 1. Reporting / BI Layer

Build a reporting and BI layer on top of the clean data pipeline.

The goal is to enable:

* Daily reports
* Weekly reports
* Automated KPI reporting
* Standard dashboards
* Recurring analysis

without requiring manual intervention.

---

## 2. Data Quality & Alerting

Create an automated alerting system to identify data-quality issues.

The system should ideally detect:

* **Incomplete data**
* **Duplicate data**
* **Incorrect data**
* Missing events
* Unexpected schema changes
* Significant changes in event volume
* Data pipeline failures

Alerts can then be sent to the relevant team when an issue is detected.

---

# Roadmap

```text
Current
   │
   ├── CleverTap Event Collection
   ├── S3 Parquet Export
   ├── Raw Tables
   ├── Clean Views
   └── Manual Analysis
          │
          ▼
Future
   │
   ├── Automated Data Quality Checks
   ├── Data Issue Alerts
   ├── Automated Daily/Weekly Reports
   └── BI / Dashboard Layer
```

---

# Summary

This pipeline provides a practical and flexible way to use CleverTap as an event collection platform while moving analytical workloads into a more controllable data environment.

The current implementation supports:

* CleverTap → S3 data export
* Parquet-based event storage
* Raw table creation
* Clean analytical views
* Flexible SQL-based analysis
* Optional clean-data backups

The primary next steps are **automation, data-quality monitoring, and a reporting/BI layer**.
