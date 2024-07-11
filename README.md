# Setting UP DBT-SERVER 
STEP 1:
Create DBTSERVER for your project:
```
cookiecutter gh:yramirez66/dbt-server
```
You will be prompted to insert the following information:
```
    "repo_name": "ClientName"
```
If nothing is parsed, the default "ClientName" will be applied.
STEP 2:
Create and Start Virtual Environment: 
```
python -m venv venv
source venv/bin/activate
```

STEP 3:
 Navigate to your dbt-server and run the following command to install all the required dependencies:
 ```
pip install -r requirements.txt -r dev-requirements.txt
```

Step 4:
Push the project you will be working with into dbt server:
 
Begin by cloning the data-platforms-dbt-base project:
```
git clone git@github.com:66degrees/data-platforms-dbt-base.git
```
Move your dbt-server into the data-platforms-dbt-base project.
Next, run the following line to access dbt-server locally:
```
ALLOW_ORCHESTRATED_SHUTDOWN=on uvicorn dbt_server.server:app --reload --host=127.0.0.1 --port 8580 
```
Now that the server is activated, in a new terminal, run the following line to push the project at the root of dbt-server:
`python3 init_project ../shared`

A successful push will show the following message:

```
PUSH 200
PARSE 200
state_id: {state_id}
project directory: {project_dir}
version_check: true,
profile: shared,
target: {project_dir}/target
```


# To Deploy into Cloud Run:
Before continuing ensure there is a repository available in Artifact Registry named dbt-server.

Begin by building a DBT-SERVER image:
```
docker build -f Dockerfile . -t dbt-server-1.7.0:latest --build-arg DBT_CORE_VERSION=1.7.0 --build-arg DBT_DATABASE_ADAPTER_PACKAGE=dbt-bigquery
```

Push local docker image to Google cloud artifact registry by running the following commands:
```
docker tag dbt-server-1.7.0:latest us-central1-docker.pkg.dev/iota-dev-66d-20231205/dbt-server/dbt_server_image:latest
docker push us-central1-docker.pkg.dev/iota-dev-66d-20231205/dbt-server/dbt_server_image:latest
```

# Configure Cloud Run
Somethings to consider include the following:
- Ensure there is a default	VPC network and at least one default subnet with the appropriate rules 
- Add a redis instance into the cloud run instance:
    - Click on the cloud run instance
    - Go into the Integration tab in the instance 
    - Click on the Redis - Google Cloud Memorystore option and create!
