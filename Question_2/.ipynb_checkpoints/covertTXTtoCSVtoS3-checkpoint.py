import pandas as pd
import boto3

#  Step 1: File Paths 
input_path = '/Users/desmondgukwe/Documents/Aligned/Aligned_AE_Test/Question_2/health_products.txt'
output_path = '/Users/desmondgukwe/Documents/Aligned/Aligned_AE_Test/Question_2/health_products.csv'

# Step 2: Convert TXT to CSV
df = pd.read_csv(input_path, delimiter=' ')
df.to_csv(output_path, index=False)
print("CSV file created successfully.")

#very bad practice creating a config file is much better bcoz we cant store secreet keys on git
aws_access_key_id = '*****'
aws_secret_access_key = '******'
aws_region = 'eu-west-1'  

s3 = boto3.client(
    's3',
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key,
    region_name=aws_region
)

bucket_name = 'processed-bucket-analytics'
s3_key = 'health_products.csv'  

try:
    s3.upload_file(output_path, bucket_name, s3_key)
    print(f"File uploaded successfully to s3://{bucket_name}/{s3_key}")
except Exception as e:
    print(f"Failed to upload file to S3: {e}")
