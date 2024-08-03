# DBT (Data Build Tool)

## Step 1. Introduction

DBT is using in data transforming process in ELT pipline.

## Step 2. Installation

- Install `Python` from `https://www.python.org/downloads/`.
- Install VSCode with plugin `Python` from Microsoft and `dbt Power User` from Altimate Inc.

Create & Activate virtual environment
```
cd .dbt-ws
python -m venv dbt_venv
./dbt_venv/Scripts/Activate.ps1
```

Install dbt with data warehouse
```
pip install dbt-postgres
```