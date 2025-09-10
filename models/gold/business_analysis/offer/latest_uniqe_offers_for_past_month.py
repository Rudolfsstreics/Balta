# 3.b.2)Python skripts kurš veic unikalitātes identifikāciju polišu piedāvājumu datos (offers). Izveidot šādas dimensijas, pēc rezultāta ieguves izanalizēt vai izveidotais risinājums ir efektīvs:
# UniqueMonth- Pēdējais unikālais piedāvājums mēneša ietvaros(30dienas);
def model(dbt, session):
    df  = dbt.ref("offer_silver")
    
    # split ids in two parts
    df[['id_part1','id_part2']] = df.id_offer.apply(lambda x: pd.Series([str(x)[:14],str(x)[16:]]))
    # cast id_part2 to int if populetade or replace by 0
    df["id_part2"] =  df["id_part2"].apply(lambda x: int(x.lstrip('0')) if len(x)>0 else 0 )
    df["dt_offer_date"] = pd.to_datetime(df["dt_offer_date"])
    # current timestamp minus the interval to get treshold datetime we are interesteed in
    now = pd.Timestamp.now() 
    datetime_cutoff = now - pd.Timedelta(days=30) 
    
    df = df[df["dt_offer_date"] >= datetime_cutoff]
    # after filtering large part of data away, idetify and return only newest offer records per infered offer id
    df = (
    df.loc[
        df.groupby(["id_part1"])["id_part2"]
               .idxmax()
    ]
    .reset_index(drop=True)
    )
    return df