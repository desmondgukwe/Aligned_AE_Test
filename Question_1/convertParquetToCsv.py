import boto3
import pandas as pd
import io

def lambda_handler(event, context):
    s3 = boto3.client('s3')

    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    obj = s3.get_object(Bucket=bucket, Key=key)
    df = pd.read_parquet(io.BytesIO(obj['Body'].read()))

    out_buffer = io.StringIO()
    df.to_csv(out_buffer, index=False)

    s3.put_object(
        Bucket='processed-bucket-analytics',
        Key=key.replace('.parquet', '.csv'),
        Body=out_buffer.getvalue()
    )

    print(f"Process completed: {key} converted and saved to processed-bucket-analytics")
    return {'statusCode': 200, 'body': 'converted'}




