import pandas as pd
df = pd.read_csv('/Users/desmondgukwe/Documents/Aligned/Aligned_AE_Test/Question_2/health_products.txt', delimiter=' ')
df.to_csv('/Users/desmondgukwe/Documents/Aligned/Aligned_AE_Test/Question_2/health_products.csv', index=False)

