# ALS를 이용하여 사용자에게 영화 추천

import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._
import org.apache.spark.mllib.recommendation.ALS
import org.apache.spark.mllib.recommendation.MatrixFactorizationModel
import org.apache.spark.mllib.recommendation.Rating

//영화 리스트 가져오기
val movie_data = spark.read.format("csv").option("header","false").option("inferSchema","true").load("/project/movie_list.csv")
val movies = movie_data.select('_c0.as("movie"), '_c1.as("title"), '_c2.as("director"), '_c3.as("company"),'_c4.as("country"), '_c5.as("genre"), '_c6.as("grade"), '_c7.as("actor1"), '_c7.as("actor2")) 

//사용자들의 평점 가져오기
val data = spark.read.format("csv").option("header","false").option("inferSchema","true").load("/project/score/ratings.csv")
val dataset = data.select('_c0.as("user"), '_c1.as("title"), '_c2.as("rating"))
val ratings = dataset.join(movies, "title").select($"user", 'movie.as("product"), $"rating")
ratings.printSchema
ratings.show

val movie_list = movies.select($"movie", $"title",array("director","country","genre","grade", "actor1").as("factor"))
movie_list.rdd.filter(row => row.getAs[Seq[String]]("factor").contains("크리스토퍼 놀란")).take(10).foreach(println)

//영화를 추천할 사용자의 기존 평점 정보 가져오기 
val data = spark.read.format("csv").option("header","false").option("inferSchema","true").load("/project/score/user.csv")
val data2 = data.select('_c0.as("user"), '_c1.as("product"), '_c2.as("rating"))
val userId = 12345
val movieIds = data2.select("product").collect.map(_.getAs[Int]("product")).toSeq

val set = ratings.randomSplit(Array(0.9, 0.1), seed = 12345)
val training = data2.unionAll(set(0)).cache()
val test = set(1).cache()
println(s"Training: ${training.count()}, test: ${test.count()}")

val trainingRDD = training.as[Rating].rdd
val usersProducts = movie_list.select(lit(userId), $"movie").map { row => (row.getInt(0), row.getInt(1)) }
val usersProducts2 = usersProducts.toJavaRDD
usersProducts2.count


val rank = 500
val numIterations = 20
val model = ALS.train(trainingRDD, rank, numIterations, 0.01)

val result = model.predict(usersProducts2).toDS()
val movies2 = movie_data.select('_c0.as("product"), '_c1.as("title"))
result.join(movies2, "product").select($"user", $"title", $"rating").sort($"rating".desc).show()