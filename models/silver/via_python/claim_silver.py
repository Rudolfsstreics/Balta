def model(dbt, session):

    claim  = dbt.ref("claim_bronze")
    policy = dbt.ref("policy_bronze")
    # Join claims and policy table to identify claims outside policy period
    policy_suffix = '_policie_cols'
    df = claim.join(policy.set_index('id_policy').add_suffix(policy_suffix), on='id_policy', how='left')
    df = df.loc[(df['d_claim_date'] >= df[f'd_policy_start_date{policy_suffix}']) & (df['d_claim_date'] <= df[f'd_policy_end_date{policy_suffix}'])]
    df = df.loc[:,~df.columns.str.endswith(policy_suffix)]

    df.drop_duplicates(subset=['id_claim'], keep='first', inplace=True, ignore_index=True)
    df = df.reset_index(drop=True)
    return df