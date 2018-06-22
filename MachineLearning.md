### MLlib를 이용하여 Default chart 만들기
#### Model 만들기

````scala
import org.apache.spark.ml.feature.StringIndexer
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.linalg.Vectors
import org.apache.spark.ml.regression.LinearRegression
import org.apache.spark.ml.feature.StringIndexer

//필요한 함수 등록
//1) string 타입을 double 타입으로 cast
spark.udf.register("toDouble", (v:String) => {v.replaceAll("[^0-9.]","").toDouble})

//2) 흥행 한 영화 / 흥행하지 않은 영화의 관객 수를 각각 0, 1로 mapping (흥행기준: 100만 관객)
def func(d: Double):Int = {
      if(d>=1000000)
     0
     else
     1
     }
spark.udf.register("viewer_level", (v: Double) => func(v) )


// csv 형태의 train data를 dataframe으로 가져와 column명 지정 및 double type으로 cast
 
val df = spark.read.csv("/project/TrainInput.csv")
val df2 = df.select('_c0.as("Title"), callUDF("toDouble", '_c1).as("Director"), callUDF("toDouble",'_c2).as("Company"),
     callUDF("toDouble",'_c3).as("Month"), callUDF("toDouble", '_c4).as("Country"), callUDF("toDouble", '_c5).as("Viewer"), 
     callUDF("toDouble", '_c6).as("Genre"), callUDF("toDouble", '_c7).as("Grade"), callUDF("toDouble",'_c8).as("Actor"))


//schema 출력
df2.printSchema()

//관객수 0,1로 mapping 
val df3 = df2.select('Title, 'Director,'Company,'Month,'Country, callUDF("viewer_level", 'Viewer).as('Viewer_level), 'Genre,'Grade, 'Actor)

val df4 = df3.limit(1200)
df4.groupBy("Viewer_level").count().show

//선형회귀에서 쓸 독립변수들을 vector의 성분으로 assemble
val assembler = new VectorAssembler().setInputCols(Array("Director","Company","Month","Country","Genre","Grade","Actor")).setOutputCol("features")
val df5 = assembler.transform(df4)

//train data, test data 7:3의 비율로 나누기
val Array(train,test) = df5.randomSplit(Array(0.7,0.3))

//선형회귀 및 train data fitting
val lr = new LinearRegression().setMaxIter(5).setRegParam(0.3).setLabelCol("Viewer_level").setFeaturesCol("features")
val model = lr.fit(train)

//만들어진 모델에 대한 r2값 계산
println("결정계수: " + model.summary.r2)

//선형회귀로 예상되는 흥행지수와 실제 흥행지수 비교하기
val df6 = model.setPredictionCol("predic_viewer").transform(df5)
df6.cache()
df6.select("Title","Viewer_level","predic_viewer").show(10,false)

````

#### 개봉될 영화의 흥행 지수 예측

````scala

val test_df = spark.read.csv("/project/TestInput.csv")
val test_df2 = test_df.select('_c0.as("Title"),callUDF("toDouble",'_c1).as("Director"),callUDF("toDouble", '_c2).as("Company"),callUDF("toDouble",'_c3).as("Month"),callUDF("toDouble",'_c4).as("Country"),callUDF("toDouble",'_c5).as("Genre"),callUDF("toDouble",'_c6).as("Grade"),callUDF("toDouble",'_c7).as("Actor"),callUDF("toDouble",'_c8).as("Twitter")
val test_df3 = assembler.transform(test_df2)
val test_df4 = model.setPredictionCol("predic_viewer").transform(test_df3)
test_df4.cache()
test_df4.select("Title","predic_viewer").show(10,false)

````
