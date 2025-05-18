# Alignd - Analytics Engineering Assessment (May 2025)

This repository contains the full solution for the Analytics Engineering Assessment, including file transformations, cloud automation using AWS, SQL integration, and dashboarding insights via Amazon QuickSight.

---

## 🚀 Overview

You are given multiple file formats (.parquet, .txt, .csv) and asked to:

1. Convert a `.parquet` file to `.csv` using AWS S3 and Lambda
`What I Did`
`Wrote the Script`
Made a Python script to read Parquet files and save the result to another bucket using awswrangler.`

Set Up Buckets
Created a source bucket (for uploads) and a destination bucket (for output).

Gave Permissions
Gave the Lambda function permission to read from the source and write to the destination bucket.

Trigger Setup
Set the function to trigger when a .parquet file is uploaded to the source bucket.

Added a Layer
Used the prebuilt AWSSDKPandas-Python39 layer so I didn’t have to install awswrangler myself.

How to Use
Just upload a Parquet file to the source bucket. The function will run and save the result to the destination bucket.`

2. Convert a `.txt` file to `.csv` using Python
What It Does
Loads health_products.txt using pandas.

Uses a space (' ') as the separator.
Saves it as health_products.csv.

How to Run
Make sure you have pandas installed:
pip install pandas

Run the script:


3. Set up PostgreSQL tables using DBeaver
What It Does
Connects to a local PostgreSQL database using SQLAlchemy.

Reads these CSV files:

clients.csv

health_lapses.csv

health_products.csv

Creates empty tables with the same column names as the CSV files.

Loads the data from the CSVs into the matching tables 

How to Use
Install the required libraries from the requeremnts file

Set up your database:
Make sure PostgreSQL is running locally and the database desmondgukwe exists.
Run the script:

4. Integrate and analyze the data using SQL
5. Visualize insights using a dashboarding tool
6. (Optional) Model data using dbt

---
Before anythinf setup your working enviroment by installing all the needed modules for this task by doing the following 

```bash
pip install -r requirements.txt

