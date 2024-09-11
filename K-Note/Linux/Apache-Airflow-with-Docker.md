# Apache Airflow with Docker

## Step 1. Preparation

Download & Install Docker Desktop

Need to update wsl on Windows
```
wsl --update
```

- https://www.docker.com/products/docker-desktop/
    - Version: 4.32.0
    - Engine: 27.0.3
    - Compose: v2.28.1-desktop.1
    - Credential Helper: v0.8.2
    - Kubernetes: v1.29.2

Create Directory

- air-flow
    - dags
    - logs
    - plugins

Create Airflow UID in `air-flow` directory

.env
```
AIRFLOW_UID=502
AIRFLOW_GID=0
```

Check latest version of Airflow

- https://airflow.apache.org/docs/apache-airflow/stable/release_notes.html

Download `docker-compose.yaml` to `air-flow` directory

- https://airflow.apache.org/docs/apache-airflow/2.9.3/docker-compose.yaml

Increase `wsl2` memory usage on Window

C:\users\[user-name]\.wslconfig
```
[wsl2]
memory=6GB
swap=6GB
```

Reboot WSL
```
wsl --shutdown
```

---

## Step 2. Installation

Run docker
```
cd air-flow
docker-compose up airflow-init
docker-compose up

docker-compose down -v # Remove docker container
```

Open new terminal and check all container change status from (health: starting) to (healthy).
```
docker ps
```

Login
```
http://localhost:8080
user: airflow
pass: airflow
```

To connect Airflow command line interface.
```
docker exec [container_id] [command]
docker exec 4aca72dd5ce2 airflow version
```

To enable access to Airflow API

docker-compose.yaml
```
x-airflow-common:
    environment:
        AIRFLOW__API__AUTH_BACKEND: 'airflow.api.auth.backend.basic_auth'
```

Test Airflow API
```
curl --user "airflow:airflow" "http://localhost:8080/api/v1/dags"
```

---

## Step 3. Architecture

What is Airflow?

- Open-source platform that empowers data professionals to efficiently Create, Schedule and Monitor Tasks & Workflows.
- Pure Python, Robust Integration with other platform (GCP, AWS, Azure, Snowfake, Databrick, On-premises), Highly Scalable, Rich Interface

What is DAG in Airflow?

- Directed - Dependencies have a specified direction
- Acyclic - No cycles or Loops
- Graph - Diagram that consists of nodes and edges

---

## Step 4. Manaual Standalone Installation

Install VSCode with plugin `Docker` & `Python` from Microsoft

Create `Dockerfile` in workspace `docker build -t sleek-airflow .`
```
FROM apache/airflow:2.9.3

USER root
RUN apt-get update && \
    apt-get -y install git && \
    apt-get clean

USER airflow
```

Create `docker-compose.yml` in workspace `docker-compose up`
```yml
services:
    sleek-airflow:
        image: sleek-airflow:latest
        volumes:
          - ./airflow:/opt/airflow
        ports:
          - "8080:8080"
        command: airflow standalone
```

Login with `admin` and password is generated in `airflow/standalone_admin_password.txt`

---

## Step 5. Create DAG

Create DAG file in `airflow/dags/welcome_dag.py`
```
# Imports
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from datetime import datetime
import requests

def print_welcome():
    print('Welcome to Airflow!')

def print_date():
    print('Today is {}'.format(datetime.today().date()))

def print_random_quote():
    response = requests.get('https://api.quotable.io/random')
    quote = response.json()['content']
    print('Quote of the day: "{}"'.format(quote))

# Define DAG
dag = DAG(
    'welcome_dag',
    default_args={'start_date': days_ago(1)},
    schedule_interval='0 23 * * *',
    catchup=False
)

# Define Tasks
print_welcome_task = PythonOperator(
    task_id='print_welcome',
    python_callable=print_welcome,
    dag=dag
)

print_date_task = PythonOperator(
    task_id='print_date',
    python_callable=print_date,
    dag=dag
)

print_random_quote = PythonOperator(
    task_id='print_random_quote',
    python_callable=print_random_quote,
    dag=dag
)

# Define Tasks Dependencies
print_welcome_task >> print_date_task >> print_random_quote
```

> Wait 5 minutes to visible in DAGs Web Interface

Dependencies can define with

- Bitshift operator `>>` and `<<`
- Setup function
    - task1.set_upstream(task2)
    - task3.set_downstream(task2)
- Chain function
    - chain(task1, task2, task3)
- Taskflow API
    - task1()
    - task2()
    - task3()

---

## Step 6. Operator Categories

1. Action Operators (Executes somethings)
    - BashOperator: Executes a bash commands
    - PythonOperator: Executes a Python code
    - AzureDataFactoryRunPipelineOperator: Run ADF Pipeline
    - EmailOperator: Sends an email
    - SnowflakeOperator: Runs SQL against a Snowflake database
    - KubernetesPodOperator: Runs Docker images in Kubernetes Pods
    - HiveOperator: Executes a HiveQL query
2. Transfer Operators (Moves Data from one place to another)
    - S3ToRedshiftOperator: Transfer data from S3 to Redshift
    - LocalFilesystemToGCSOperator: Upload data from local filesystem to GCS
    - S3ToGCSOperator: Transfer data from S3 to Google Cloud Storage
    - S3ToSnowflakeOperator: Loads file from S3 to Snowflake
    - SFTPToWasbOperator: Transfer data from SFTP to Azure Blob
    - MySqlToHiveOperator: Moves data from MySql to Hive
3. Sensor Operators (Waits for something)
    - FileSensor: Wait for files to be available in Local File System
    - SqlSensor: Waits for data to be present in a table
    - DateTimeSensor: Waits for a specified date and time
    - HttpSensor: Waits for an HTTP endpoint to be available
    - HttpSensorAsync: Wait for a response from an HTTP endpoint
    - ExternalTaskSensor: Waits for a task in another DAG to complete
    - BigQueryTableExistenceSensor: Checks for the existence of a table in Google BigQuery
    - S3KeySensor: Waits for files to be available in S3
    - RedshiftClusterSensor: Waits for a Redshift cluster status
    - RedishPubSubSensor: Listens for messages on a Redis channel

Check required provider's packages at `https://airflow.apache.org/docs/apache-airflow-providers/packages-ref.html`

Add `Dockerfile` at last line
```
# Install the Github provider package
RUN pip install apache-airflow-providers-github
```

Or can add with `requirements.txt`.

Dockerfile
```
# Install provider packages from requirements.txt
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt --trusted-host=pypi.python.org --trusted-host=pypi.org --trusted-host=files.pythonhosted.org
```

requirements.txt
```
apache-airflow-providers-github
# Add more provider package as needed
```

After that build image and restart docker container. Github need to create connection id from `Menu > Admin > Connections` detail show in Step 8.

---

## Step 7. Airflow Admin

### Variable

Variable is key and value pair.
- Regular string
- JSON string

To create variable, goto `Menu > Admin > Variables`. Variable is useful for email address, access token, environment specific, dynamic date range, etc.
```
to="{{ var.value.get('support_email') }}",
bash_command="curl '{{ var.value.get('web_api_key') }}'",
start_date="{{ var.json.process_interval.start_date }}"
```

### Connection

To connect to external system, need to create connection id at `Menu > Admin > Connections`.

---

## Step 8. Sensor & Trigger

Parameters are need depent on Sensor. Basic parameters are:
- poke_interval: Define in second. `60 * 10` means 10 minutes.
- mode: `poke` default and `reschedule` is not allocate worker.
- timeout: Define in second. `60 * 60 * 24 * 7` means 7 days.
- soft_fail: `True` mean skip this or `False` mean error.
- deferrable: `True` enable for trigger (sometime call asyn, trigger)


---

## Step 9. Cross Communication between Tasks (Xcom)

```
# Set value to Xcom
ti.xcom_push(key='xrate_file', value=xrate_filename)

# Get value from Xcom
to.xcom_pull(task_ids='fetch_xrate', key='xrate_file')
```

The size limit for an Xcom is depend on database.
- Postgres: 1 GB
- SQLite: 2 GB
- MySQL: 64 KB

---

## Step 10. Hooks & Operators

Both are writen in Python.

- Low Level Code
    - Hooks (Detail level of most feature)
        - Operators (Using some of Hooks function)

> If task can't do with Operators, find and use Hooks. If Operators and Hooks can't do task, need to write your Python code.

---

## Step 11. Dataset

Dataset can be define as follow:
```
Dataset("s3://bucket-name/file_name.csv")
Dataset("/path/to/file.csv")
Dataset("fx_rate_file")
```

- Dataset Producer DAG
    - `outlets=[Dataset("s3://sleek-data/oms/xrate.json")]`
- Dataset Consumer DAG (auto trigger to producer)
    - `schedule=[Dataset("s3://sleek-data/oms/xrate.json")]`

---

## Step 12. Manage Flow of Tasks

1. Branching
2. Trigger Rules
3. Setup and Teardown
4. Latest Only
5. Depends On Past

---

## Step 13. Task Flow API (above Airflow 2.0)

Test with and without `@decorator_example`
```
# Decorator Function
def dec_ex(org_fun):
    def wrapper():
        print('Before')
        org_fun()
        print('After')
    return wrapper

# Original Function Definition
@dec_ex
def say_hello():
    print('Hello')

# Original Function Call
say_hello()
```

Build in Decorator
- `@task()`: Creates a Python task
- `@dag()`: Creates a DAG
- `@task_group()`: Creates a Task Group
- `@task.virtualenv()`: Run task in a virtual environment
- `@task.docker()`: Creates a Docker Operator task
- `@task.kubernetes()`: Creates KubernetesPodOperator task
- `@task.branch()`: Creates a branch based on condition

Create DAG file in `airflow/dags` directory.

taskflow_api.py
```
from airflow import DAG
from airflow.decorators import task
from airflow.utils.dates import days_ago

@task
def extract():
    return "Raw"

@task
def transform(raw):
    return f"Processed: {raw}"

@task
def validate(process):
    return f"Validated: {process}"

@task
def load(valid):
    print(f"Loaded: {valid}")

dag = DAG(
    'taskflow_api',
    default_args={'start_date': days_ago(1)},
    schedule_interval='0 21 * * *',
    catchup=False
)

with dag:
    load_task = load(validate(transform(extract()))) 
```

---

## Step 14. Airflow 2 with Postgres 13

Dockerfile
```
FROM apache/airflow:2.9.3

USER root
RUN apt-get update && \
    apt-get -y install git && \
    apt-get clean

USER airflow

RUN pip install --upgrade pip

# Install provider package from requirements.txt
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt --trusted-host=pypi.python.org --trusted-host=pypi.org --trusted-host=files.pythonhosted.org

# RUN pip install --trusted-host=pypi.python.org --trusted-host=pypi.org --trusted-host=files.pythonhosted.org apache-airflow-providers-github
```

requirements.txt
```
# Data Analysis
pandas
numpy
scipy
statsmodels
dask

# Data Visualization
matplotlib
seaborn
plotly
bokeh
altair

# Database
sqlalchemy
psycopg2-binary

# Airflow Provider
apache-airflow-providers-github
apache-airflow-providers-postgres

# Add more provider package as needed
```

Create docker image for `docker-composer.yml`
```
docker build -f Dockerfile -t my-airflow .
```

docker-compose.yml
```yml
name: my-airflow

services:
    postgres:
        image: postgres:13
        ports:
          - '5432:5432'
        environment:
            POSTGRES_USER: airflow
            POSTGRES_PASSWORD: airflow
            POSTGRES_DB: airflow
        volumes:
          - ./postgres:/var/lib/postgresql/data

    airflow:
        image: my-airflow:latest
        environment:
            AIRFLOW__CORE__EXECUTOR: LocalExecutor
            AIRFLOW__DATABASE__SQL_ALCHEMY_CONN: postgresql+psycopg2://airflow:airflow@postgres/airflow
        volumes:
          - ./airflow:/opt/airflow
        ports:
          - "8080:8080"
        command: airflow standalone
        depends_on:
          - postgres

    pgadmin:
        image: dpage/pgadmin4:8.10
        ports:
          - '80:80'
        environment:
            PGADMIN_DEFAULT_EMAIL: 'admin@local.com'
            PGADMIN_DEFAULT_PASSWORD: 'admin'
        volumes:
          - ./pgadmin:/var/lib/pgadmin
```

Create docker container with `docker-compose`
```
docker-compose up -d      # Run in background
docker-compose down -v    # Recreate anonymous volume
```

> Login to `http://localhost:8080` with username `admin` and password is generated in `airflow/standalone_admin_password.txt`

