def model(dbt, session):
    df  = dbt.ref("offer_bronze")
    df = df.drop_duplicates(subset=['id_offer'], keep='first', ignore_index=True)
    df = df.reset_index(drop=True)
    schema = pa.DataFrameSchema(
        {"id_offer": pa.Column(str),
        "customer_id": pa.Column(int, pa.Check(lambda x: x > 0)),
        "offer_product_code": pa.Column(str),
        "offer_product_variant_name": pa.Column(str),
        "dt_offer_date": pa.Column(pa.DateTime, pa.Check(lambda x: x < datetime.today())),
        "amt_offer_premium": pa.Column(np.float64, pa.Check(lambda x: x > 0)),
        "offer_sales_source_name": pa.Column(str),
        "sum_insured": pa.Column(np.float64, pa.Check(lambda x: x > 0)),
        "offer_coverage_hash": pa.Column(str, pa.Check(lambda x: len(x) == 32))},
                index=pa.Index(int),
                drop_invalid_rows=True,
                coerce =True,
        )
    df = schema(df, lazy=True)
    return df