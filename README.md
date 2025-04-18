# Soccer Match Analysis Project

## Overview
This project aims to analyze soccer match results from [Football-Data](https://football-data.co.uk/). The dataset contains English Premier League (EPL) match results from season 2000/01 to 2024/25. It provides various match statistics such as goals scored/conceded and total shots/shots on target. Through building an end-to-end data pipeline using a variety of tools, data ingestion, transformation and visualization are enabled in an end-to-end process. This project aims to address the following questions:

* How does the Big 6 premier league rankings change over time?
* Which matches had the largest victory margin?
* Which teams have dropped the most number of points when leading at half-time?
* Which team holds the record for most goals scored in a season?
* Which team holds the record for least goals conceded in a season?
* Which team holds the record for most home games unbeaten?
* Which team holds the record for most away games unbeaten?
* How does the shot conversion rate look like for teams within a season?

##### * The Big 6 is an informal term used to describe a group of six clubs in the Premier League (Arsenal, Chelsea, Liverpool, Manchester City, Manchester United, and Tottenham Hotspur). These clubs are often recognized for their sustained success and financial strength in the competition.


## Problem Statement
The primary objective is to develop a dashboard that visualizes:
* Various records that demonstrate excellence, such as goals scored/conceded and unbeaten streaks.
* League positions over time, particularly focusing on the Big 6 to track their performance across seasons.
* How clinical teams are across seasons, by tracking their shot conversion rate.

A key challenge is that different seasons may not have the same match statistics. This has been addressed when developing the Python script in Kestra to ensure successful pipeline run. A solution that handles schema evolution could be implemented as an alternative solution.


## Directory Structure


## Data Architecture

## Data Source

Match results were scraped from _____. For simplicity, the project focuses on EPL data.


The dashboard I created focuses on two key aspects:

* Product Ratings – Comparison between ratings in different products.

* Price & Discount Comparisons – Examining pricing strategies and discounts across different products.

[Link to Power BI dashboard](https://github.com/tsk93/DE-zoomcamp-project/blob/main/images/dashboard.jpg)



## Tools 🛠️

I've worked with this tools in order to complete the project:
* **Terraform**: Configures the bucket in GCP (IaC) 🏗️ 
* **Docker**: Container to host the Kestra platform. 🐳
* **Kestra**: Orchestration Platform 🔄
* **Google Cloud Platform**: ☁️
    - **Google Cloud Storage**: Data Lake Storage
    - **BigQuery**: Data Warehouse 
    - **Power BI**: Data visualization
* **Python**: Pipeline to clean the data ⚙️
* **dbt**: Data transformation 📥

![flowchart_project](https://github.com/saraisab/Amazon_project_DE_saraisab/blob/main/images/Flowchart.jpeg)

## Dataset 🎛️
The dataset I choose was: *Amazon Products Sales Dataset 2023* from Kaggle

Link here: [Amazon Products Sales Dataset 2023](https://www.kaggle.com/datasets/lokeshparab/amazon-products-dataset/code)

- Its product data are separated by 142 categories in csv format.
- Each csv files are consist of 10 columns and each row has products details accordingly
#### Features
| name             | description                                                    |
| ---------------- | -------------------------------------------------------------- |
| _name_           | The name of the product                                        |
| _main_category_  | The main category of the product belong                        |
| _sub_category_   | The main category of the product belong                        |
| _image_          | The image of the product look like                             |
| _link_           | The amazon website reference link of the product               |
| _ratings_        | The ratings given by amazon customers of the product           |
| _no of ratings_  | The number of ratings given to this product in amazon shopping |
| _discount_price_ | The discount prices of the product                             |
| _actual_price_   | The actual MRP of the product                                  |


----

## Steps to start running the Project

**Prerequisites**

To run this project you need to have installed these tools: Kestra, Terraform, Docker and an account in Google Cloud Platform. Moreover, I've used WSL in windows for Linux.

* Firstly: 
    * Copy to your directory the Terraform files. Change the key path if it is necessary. Execute these three commands separately:
   ```
    terraform init
    terraform plan
    terraform apply
    ```
* Secondly:
    * With docker working, write this in the subsystem Linux to start the Kestra platform:
    ```
    docker run --pull=always --rm -it -p 8080:8080 --user=root -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/tmp kestra/kestra:latest server local
    ```
    To start the Kestra environment in your webserver type:
    http://localhost:8080
    * Import all the flows in the [Kestra_flows directory](https://github.com/saraisab/Amazon_project_DE_saraisab/tree/main/Kestra_flows) to your kestra environment.
    (Ensure to include your google cloud keys into the *project_zoomcamp.01_gcp_kv.yml* file)

* Thirdly:
    * Run the flow_controller.yml. This is going to:
        * Set the configuration file that manages Google Cloud Platform (GCP) key-value pairs. It is for manage the enviroment variables in Kestra.
        * Data ingestion: Download the datasets from kaggle, insert the raw csv files into the bucket previously created.  
        * ETL: Download the data from the datalake to clean and transform the data employing the pandas library from python. Besides, upload the data to BigQuery making use of the DLT resources in python.
* Finally:
    * Run the flow *project_zoomcamp.05_bigquery_querys.yml*. It needs the name of your dataset created by DLT as an input. It is going to be creating the data models. With this, new tables and views in BigQuery are going to be created, inserted and updated, which are necessary for the final dashboard. I have divided the data from one table into three to reduce data redundancy and make easier the data management. I have clustered the main table (amazon_products) in order to improve query performance, to reduce the number of scanned bytes for queries and for cost optimization. 

    ![Data_models](https://github.com/saraisab/Amazon_project_DE_saraisab/blob/main/images/sql_models.jpeg)

## Tests
* In kestra you can check the logs, if there exist any error, it will help you. Besides, in the flow_controller there are several "prints" to give information about the process running, you can check it in the logs.

* To test the data validation in BigQuery you can run these querys:
    * It'll tell you if there exist any null in the clustered table:
        ```sql
        SELECT 
            SUM(CASE WHEN no_of_ratings IS NULL THEN 1 ELSE 0 END) AS no_of_ratings_null,
            SUM(CASE WHEN ratings IS NULL THEN 1 ELSE 0 END) AS ratings_null,
            SUM(CASE WHEN discount_price IS NULL THEN 1 ELSE 0 END) AS discount_price_null,
            SUM(CASE WHEN actual_price IS NULL THEN 1 ELSE 0 END) AS actual_price_null
        FROM 
            `project_name.dataset_name.amazon_products_clustered`;
        ```

    * Query to guess the total number of the rows, *in my case it's 1.103.170*:
        ```sql
        SELECT 
            COUNT(*) AS Total_rows
        FROM 
            `project_name.dataset_name.amazon_products_clustered`;

## Data Architecture

* TBD


## Steps to Reproduce Project

Prerequisites

* Google Cloud Platform account
* Terraform installed
* Docker and Docker Compose installed
* Git installed
* No dbt cloud account is required, as you can leverage the dbt plugin in Kestra for workflow orchestration.

### 1. Preparation

    git clone https://github.com/your-username/DE-zoomcamp-project.git
    cd DE-zoomcamp-project


Fork project repo, the URL will be required for Kestra dbtCLI step. You should have a git repo link that resembles below:
    
    https://github.com/your-username/DE-zoomcamp-project.git


### 2. Google Cloud Platform (GCP) Setup

#### Create GCP Project
* Go to Google Cloud Console and create a new project. 
* Note the project ID and project number.
* Enable account billing

#### Create Service Account and Authorization
* Create a new service account
* Grant the service account the following permissions:
    * Storage Admin
    * BigQuery Admin
    * Dataflow Admin

* In IAM & Admin --> Service Accounts, select Manage Keys. Create a new key and download as JSON file.
* Save the key file to a secure location.



### 3. Create GCP Infrastructure with Terraform

* Navigate to the terraform directory and modify the credentials and project variables in variables.tf file as required.

Credentials value: JSON key file location within terraform folder
Project value: GCP Project ID

Run the following commands:
* terraform init
* terraform plan
* terraform apply

After completion, you should see the following resources in the GCP console:

GCS bucket: `capstone_bucket_2025` <br>
BigQuery datasets: `capstone_dataset_2025` and `dbt_premierleague_analytics`


### 4. Configure Kestra

* Run docker compose up and use localhost:8080 to access Kestra UI.
* Run the following commands to upload flows to Kestra, alternatively you can upload them manually from the kestra folder.

    * `curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@kestra/01_gcp_kv.yml`
    * `curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@kestra/02_download_csv.yml`

* Currently a scheduled trigger has been set for the data extraction (12am daily, UTC+8). As Kestra scheduled triggers use UTC, you may adjust your preferred time accordingly (either by direct calculation or using the timezone property).

* Execute 01_gcp_kv.yml to set up the key value pair. In the repo, do ensure that GCP_BUCKET_NAME, GCP_DATASET and GCP_LOCATION correspond to the values that were configured in Terraform earlier. You will need to specify the GCP_CREDS by pasting in the content from the JSON key file, and also the GCP_PROJECT_ID which you have noted down earlier when creating the GCP project.

* You will need to replace the URL of the Github repo in the `id: sync` task (after `id: purge_files`) with the one that you have after forking the Github repo.

* For any changes you have made to files in the dbt folder, you will need to commit your new changes in the Github repo and re-run the Kestra flow. Changes will be applied via dbtCLI and updated in BigQuery.


### 5. Dashboard Visualization Setup

More details on the dashboard visualization can be found in zoomcamp_project.pbix.

Steps to connect BigQuery to Power BI
 * Connect to data source: From Get Data choose "Google BigQuery", and connect.
 * Under Advanced Options, key in project ID.
 * If signed in via Organizational account, follow the given instructions and log in.
 * If signed in via Service Account Login, use this [link](https://w3percentagecalculator.com/json-to-one-line-converter/) to convert the JSON key file content into a one-liner and paste into service account content box.
 * After successful connection, you will be able to see the dbt tables. Select and load the following queries:

        dim_season
        fct_away_streak
        fct_home_streak
        fct_goals_scored
        fct_goals_conceded
        fct_goal_margin
        fct_points_dropped
        fct_ranking
        fct_shot_conversion


 <img src="https://github.com/tsk93/DE-zoomcamp-project/blob/main/images/dashboard.jpg"  width="900" height="700">

Observation: 
* If a team has more shots on target, it is more likely they will score goals.
* It has been almost 20 years since Chelsea established the record for least goals conceded in a season, and it is an extremely remarkable achievement given the number of quality players back then.
* Man City set the record for most goals scored in 2017/18, boasting an impressive shot conversion rate of approximately 41%. It is also no surprise that they won several matches by an impressive goal margin.
* It is generally observed that the Big 6 teams finish in the top half of the table (1st-10th), which reflects their dominance in the league.


## Future Improvements

| Scope | Item |
| :---: |  :---:  |
| Data   | <li>Include match data from other top leagues (eg. Bundesliga, La Liga, Serie A etc)</li> <li>Include match data from lower-level leagues to calculate promotion/relegation statistics</li><li>Include player data to calculate player statistics (eg. goals scored/clean sheets made etc)</li> |
| Workflow Orchestration   | <li>To include workflow steps to handle failure (eg. schema evolution, data type conversion failure etc)</li><li>Explore opportunity to use file metadata information within pipeline</li><li>Incorporate pipeline scheduling/backfill</li><li>Incremental data loading to avoid table truncate/insert, especially if data volume is very large</li> |
| Data Transformation   | <li>Explore other components of dbt (eg. snapshots, seeds, documentation etc)</li> <li>Explore Spark transformations as an alternative solution to dbt (eg. using Dataproc in GCP, SparkCLI in Kestra)</li> |
| IaC   | <li> Explore use of GCP VM to help with project deployment </li> |
| CI/CD | <li> Explore use of Kestra and dbt to create a CI/CD pipeline



## Folders/Root Files Information



    ├── README.md
    ├── dbt
    │   ├── dbt_project.yml
    │   ├── macros
    │   │   ├── away_match_result.sql
    │   │   ├── dropped_points_away.sql
    │   │   ├── dropped_points_home.sql
    │   │   ├── home_match_result.sql
    │   │   ├── points.sql
    │   │   └── streak.sql
    │   └── models
    │       ├── core
    │       │   ├── dim_season.sql
    │       │   ├── fct_away_streak.sql
    │       │   ├── fct_goal_margin.sql
    │       │   ├── fct_goals_conceded.sql
    │       │   ├── fct_goals_scored.sql
    │       │   ├── fct_home_streak.sql
    │       │   ├── fct_points_dropped.sql
    │       │   ├── fct_ranking.sql
    │       │   └── fct_shot_conversion.sql
    │       └── staging
    │           ├── schema.yml
    │           ├── stg_away.sql
    │           ├── stg_away_streak.sql
    │           ├── stg_home.sql
    │           ├── stg_home_streak.sql
    │           ├── stg_points_dropped.sql
    │           ├── stg_ranking.sql
    │           └── stg_shot_conversion.sql
    ├── docker-compose.yml
    ├── images
    │   └── dashboard.jpg
    ├── kestra
    │   ├── 01_gcp_kv.yml
    │   └── 02_download_csv.yml
    ├── terraform
    │   ├── keys
    │   ├── main.tf
    │   └── variables.tf
    └── zoomcamp_dashboard.pbix


## Acknowledgements
This project is created as part of [Data Engineering Zoomcamp 2025](https://github.com/DataTalksClub/data-engineering-zoomcamp) project submission. I would like to thank [DataTalksClub](https://github.com/DataTalksClub) for providing this learning opportunity.    