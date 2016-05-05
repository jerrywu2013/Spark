#Author:Jerry Wu
#E-mail:jerry@mail.ntust.edu.tw


Sys.setenv(SPARK_HOME = "C:\spark")
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
library(SparkR)

#sc <- sparkR.init()
sc <- sparkR.init(master = "local[*]", sparkEnvir = list(spark.driver.memory="4g"))
sqlContext <- sparkRSQL.init(sc)

df <- createDataFrame(sqlContext, faithful)

head(df)

sc <- sparkR.init(appName="SparkR-DataFrame-example")
sqlContext <- sparkRSQL.init(sc)

localDF <- data.frame(name=c("John", "Smith", "Sarah"), age=c(19, 23, 18))

# Create a simple local data.frame
localDF <- data.frame(name=c("John", "Smith", "Sarah"), age=c(19, 23, 18))

# Convert local data frame to a SparkR DataFrame
df <- createDataFrame(sqlContext, localDF)
printSchema(df)

# SparkR automatically infers the schema from the JSON file
path <- file.path(Sys.getenv("SPARK_HOME"), "examples/src/main/resources/people.json")
peopleDF <- read.json(sqlContext, path)
printSchema(peopleDF)

##DataFrame Operations

# Create the DataFrame
df <- createDataFrame(sqlContext, faithful)
df
head(select(df, df$eruptions))
head(select(df, "eruptions"))
head(filter(df, df$waiting < 50))

##Grouping, Aggregation
head(summarize(groupBy(df, df$waiting), count = n(df$waiting)))
waiting_counts <- summarize(groupBy(df, df$waiting), count = n(df$waiting))
head(arrange(waiting_counts, desc(waiting_counts$count)))

##Operating on Columns
df$waiting_secs <- df$waiting * 60
head(df)


##Generalized linear model 
sc <- sparkR.init(master = "local[*]", sparkEnvir = list(spark.driver.memory="4g"))
sqlContext <- sparkRSQL.init(sc)
newiris<-iris
names(newiris)<-c("Sepal_Length","Sepal_Width","Petal_Length","Petal_Width","Species")
df <- createDataFrame(sqlContext, newiris)
model <- glm(Sepal_Length ~ Sepal_Width + Species, data = df, family = "gaussian")
summary(model)

head(select(df, df$Sepal_Length))
head(select(df,"Sepal_Length"))
head(filter(df, df$Sepal_Length < 4.7))



######################################
# Load a JSON file
path <- file.path(Sys.getenv("SPARK_HOME"), "examples/src/main/resources/people.json")
people <- read.df(sqlContext, path, "json")

# Register this DataFrame as a table.
registerTempTable(people, "people")

# SQL statements can be run by using the sql method
teenagers <- sql(sqlContext, "SELECT name FROM people WHERE age >= 13 AND age <= 19")
head(teenagers)
##    name
##1 Justin

######################################
# Starting Point: SQLContext
sqlContext <- sparkRSQL.init(sc)
#Creating DataFrames
sqlContext <- SQLContext(sc)
path <- file.path(Sys.getenv("SPARK_HOME"), "examples/src/main/resources/people.json")
df <- read.df(sqlContext, path, "json")
# Displays the content of the DataFrame to stdout
showDF(df)
#showDF(df,150)


# Select everybody, but increment the age by 1
showDF(select(df, df$name, df$age + 1))

# Select people older than 21
showDF(where(df, df$age > 21))

# Count people by age
showDF(count(groupBy(df, "age")))

#########################################
#https://spark.apache.org/docs/1.6.1/api/R/
sc <- sparkR.init(master = "local[*]", sparkEnvir = list(spark.driver.memory="12g"))
#sc <- sparkR.init()
x2 <- runif(100000000, 5.0, 7.5)
sqlContext <- sparkRSQL.init(sc)
dfx<-as.data.frame(cbind(x2,x2))
names(dfx)<-c("x1","x2")
df <- createDataFrame(sqlContext, dfx)

#system.time(showDF(df,50000))
#system.time(head(dfx,50000))

system.time(sum(df$x2))
########Other R
system.time(sum(x2))
