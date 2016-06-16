#### SparkR on windows 8

sc <- sparkR.init(master = "local[*]", sparkEnvir = list(spark.driver.memory="4g"))
#sc <- sparkR.init()
x2 <- runif(10000000, 5.0, 7.5)
sqlContext <- sparkRSQL.init(sc)
dfx<-as.data.frame(cbind(x2,x2))
names(dfx)<-c("x1","x2")
df <- createDataFrame(sqlContext, dfx)

system.time(showDF(df,50000))
system.time(dfx)
