
What I Did:
Wrote the Script
Created a Python Lambda function to read .parquet files using awswrangler and save the result to a destination bucket.

Set Up Buckets
Created a source bucket (for uploads) and a destination bucket (for processed output).

Gave Permissions
Gave the Lambda function permission to read from the source and write to the destination bucket.

Trigger Setup
Configured the function to trigger on .parquet uploads to the source bucket.

Added a Layer
Used the prebuilt AWSSDKPandas-Python39 Lambda layer so I didn’t need to install awswrangler manually.

How to Use:
Just upload a .parquet file to the source bucket — the function runs automatically and stores the result in the destination bucket.

