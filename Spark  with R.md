# Spark 1.6 with R on Ubuntu 14.04 LTS

####Install Spark
```
sudo apt-get update
sudo apt-get -y install openjdk-7-jdk
sudo apt-get -y install scala
wget http://www.us.apache.org/dist/spark/spark-1.6.0/spark-1.6.0-bin-hadoop2.6.tgz
tar zxvf spark-*.tgz
mv spark-1.6.0-bin-hadoop2.6 /usr/local/spark
```
###Install R
```
sudo apt-get update
sudo apt-get -y install r-base
sudo apt-get -y install r-base-dev
```
###Interactive with R
```
R
Sys.setenv(SPARK_HOME = "/usr/local/spark")
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sc <- sparkR.init()
sqlContext <- sparkRSQL.init(sc)
```
