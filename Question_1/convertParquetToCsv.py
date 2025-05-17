import boto3
import pandas as pd
import io
#The scripts attempts to Get file location from trigger event then  Download and convert the file & lastly Save as CSV to new location
def lambda_handler(event, context):
    s3 = boto3.client('s3')
    
    try:
        
        bucket = event['Records'][0]['s3']['bucket']['name']
        file_key = event['Records'][0]['s3']['object']['key']
        
        
        parquet_data = s3.get_object(Bucket=bucket, Key=file_key)['Body'].read()
        df = pd.read_parquet(io.BytesIO(parquet_data))
        
        
        csv_file = io.StringIO()
        df.to_csv(csv_file, index=False)
        s3.put_object(
            Bucket='processed-bucket-analytics',
            Key=file_key.replace('.parquet', '.csv'),
            Body=csv_file.getvalue()
        )
        
        return {'status': 'success'}
        
    except Exception as e:
        return {'status': 'error', 'message': str(e)}

