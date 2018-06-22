#### MLlib를 이용한 linear regression

````javascript
import org.apache.spark.ml.feature.StringIndexer
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.linalg.Vectors
import org.apache.spark.ml.regression.LinearRegression
import org.apache.spark.ml.feature.StringIndexer

//필요한 함수 등록
//1) string 타입을 double 타입으로 cast
spark.udf.register("toDouble", (v:String) => {v.replaceAll("[^0-9.]","").toDouble})

//2) 흥행 한 영화 / 흥행하지 않은 영화를 각각 0, 1로 mapping (흥행기준: 100만 관객)
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

````
