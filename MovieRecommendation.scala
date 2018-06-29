# ALS를 이용하여 사용자에게 영화 추천

import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._
import org.apache.spark.mllib.recommendation.ALS
import org.apache.spark.mllib.recommendation.MatrixFactorizationModel
import org.apache.spark.mllib.recommendation.Rating
import java.util.Properties
import org.apache.spark.sql.SaveMode

val args  = sc.getConf.get("spark.driver.args").split("\\s+")
val userId = args(0).toInt

val connectionProperties = new Properties()
connectionProperties.put("user", "root")
connectionProperties.put("password", "123456")
connectionProperties.put("user", "root")
connectionProperties.put("password", "123456")

val jdbcUrl = "jdbc:mysql://slave01:3306/hadoop"

val movies 	= spark.read.jdbc(jdbcUrl, "hadoop.movieList", connectionProperties)
val data   	= spark.read.jdbc(jdbcUrl, "hadoop.ratings_title", connectionProperties)
val ratingAll 	= data.join(movies, "title").select($"user", $"product", $"rating")
ratingAll.printSchema()
ratingAll.show()

val user 	= ratingAll.where(s"user == $userId")
val ratings 	= ratingAll.where(s"user != $userId")

val movieIds = user.select("product").collect.map(_.getAs[Int]("product")).toSeq

val set = ratings.randomSplit(Array(0.9, 0.1), seed = 12345)
val training = user.unionAll(set(0)).cache()
val test = set(1).cache()
println(s"Training: ${training.count()}, test: ${test.count()}")

val trainingRDD = training.as[Rating].rdd
val usersProducts = movies.select(lit(userId), $"product").map { row => (row.getInt(0), row.getInt(1)) }
val usersProducts2 = usersProducts.toJavaRDD
usersProducts2.count

val rank = 200
val numIterations = 20
val model = ALS.train(trainingRDD, rank, numIterations, 0.01)
val result = model.predict(usersProducts2).toDS()
val rcmd = result.join(movies, "product").select($"user", $"title", $"rating").sort($"rating".desc)
rcmd.show()
rcmd.write.mode(SaveMode.Overwrite).jdbc(jdbcUrl, "hadoop.rcmd", connectionProperties)
