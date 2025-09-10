def model(dbt, session):
    df  = dbt.ref("customer_bronze")
    df.drop_duplicates(subset=['id_customer'], keep='first', inplace=True, ignore_index=True)
    df = df.reset_index(drop=True)
    return df