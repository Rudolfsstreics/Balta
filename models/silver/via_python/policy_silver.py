def model(dbt, session):
    df  = dbt.ref("policy_bronze")
    df.drop_duplicates(subset=['id_policy'], keep='first', inplace=True, ignore_index=True)
    df = df.reset_index(drop=True)
    return df