import org.apache.spark.SparkContext
import org.apache.spark.SparkConf
import org.apache.spark.ml.feature.StringIndexer
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.linalg.Vectors
import org.apache.spark.ml.regression.LinearRegression
import org.apache.spark.ml.feature.StringIndexer
import spark.implicits._
import java.util.Properties
import org.apache.spark.sql.SaveMode

val connectionProperties = new Properties()
connectionProperties.put("user", "USER")
connectionProperties.put("password", "PASSWORD")
connectionProperties.put("user", "USER")
connectionProperties.put("password", "PASSWORD")

val jdbcUrl = "jdbc:mysql://slave01:3306/hadoop"

//관객수를 0 과 1과 맵핑하는 함수
def func(d: Int):Int = {
      if(d>=1000000)
         0
      else
	 1
      }

spark.udf.register("viewer_level", (v: Int) => func(v) )

//머신러닝으로 예측된 흥행지수를 정규화
def scorefunc(d: Double):Double = {
      (2-d)*4
}
spark.udf.register("scorefunc", (v: Double) => scorefunc(v) )


val df = spark.read.format("csv").option("header","true").option("inferSchema","true").load("/project/TrainInput.csv")
val df3 = df.select('Title, 'Director,'Company,'Month,'Country, callUDF("viewer_level", 'Viewer).as('Viewer_level), 'Genre,'Grade, 'Actor)


val assembler = new VectorAssembler().setInputCols(Array("Director","Company","Month","Country","Genre","Grade","Actor")).setOutputCol("features")

val df4 = df3.limit(1200)
df4.groupBy("Viewer_level").count().show
val df5 = assembler.transform(df4)

val Array(train,test) = df5.randomSplit(Array(0.7,0.3))

val lr = new LinearRegression().setMaxIter(5).setRegParam(0.3).setLabelCol("Viewer_level").setFeaturesCol("features")
val model = lr.fit(train)
println("결정계수: " + model.summary.r2)


val df6 = model.setPredictionCol("predic_viewer").transform(df5)
df6.cache()
df6.select("Title","Viewer_level","predic_viewer").show(10,false)

//val test_df = spark.read.format("csv").option("header","false").option("inferSchema","true").load("/project/TestInput_180709.csv")
val test_df = spark.read.format("csv").option("header","false").load("/project/TestInput_180709.csv")

val test_df2 = test_df.select('_c0.as("Title"),'_c1.as("Director").cast("int"), '_c2.as("Company").cast("int"),'_c3.as("Month").cast("int"),'_c4.as("Country").cast("int"),'_c5.as("Genre").cast("int"),'_c6.as("Grade").cast("int"),'_c7.as("Actor").cast("double"),'_c8.as("r_date").cast("date"),'_c9.as("twitter").cast("double")).filter("r_date is not null")

test_df2.printSchema()

val test_df3 = assembler.transform(test_df2)
val test_df4 = model.setPredictionCol("predic_viewer").transform(test_df3)
test_df4.cache()
val test_df5 = test_df4.select($"Title".as("title"),$"predic_viewer", $"twitter",$"r_date").sort($"predic_viewer".asc)
test_df5.show(100)

val test_df6 = test_df5.select($"title", callUDF("scorefunc", 'predic_viewer).as("predict"), $"twitter", $"r_date")
val test_df7 = test_df6.select($"title", $"predict" + $"twitter", $"r_date")
val test_df8 = test_df7.select($"title", $"(predict + twitter)".as("prediction"), $"r_date")
test_df6.select($"title", $"predict" + $"twitter", $"r_date").sort($"(predict + twitter)".desc).show(100)

test_df8.write.mode(SaveMode.Overwrite).jdbc(jdbcUrl, "hadoop.defaultChart", connectionProperties)


System.exit(1)


