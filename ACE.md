# Google Cloud
## Associate Cloud Engineer (ACE)
---

## Interacting with Google Cloud

### Cloud Shell

Create google cloud storage
```
gcloud storage buckets create gs://<BUCKET_NAME>
```

Copy file from `Cloud Shell` to storage buckets
```
gcloud storage cp [MY_FILE] gs://[BUCKET_NAME]
```

Setup default variable name
```
gcloud compute regions list
mkdir infraclass
touch infraclass/config
```

Write value in config 
```
echo INFRACLASS_REGION=[region] >> ~/infraclass/config
echo INFRACLASS_PROJECT_ID=[project_id] >> ~/infraclass/config
```

Edit `nano .profile` file and add at end
```
source infraclass/config
```
