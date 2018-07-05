import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._
import java.util.Properties
import org.apache.spark.sql.SaveMode

//사용자의 아이디 받기
val args  = sc.getConf.get("spark.driver.args").split("\\s+")
val userId = args(0)

//jdbc연결
val connectionProperties = new Properties()
connectionProperties.put("user", "USERID")
connectionProperties.put("password", "PASSWORD")
connectionProperties.put("user", "USERID")
connectionProperties.put("password", "PASSWORD")

val jdbcUrl = "jdbc:mysql://slave01:3306/hadoop"

//영화 리스트와 사용자가 본 영화 목록 받기
val movieList 	= spark.read.jdbc(jdbcUrl, "hadoop.movieList", connectionProperties).select($"product", $"title",$"director", $"country", $"actor1".as("actor"), $"genre")
val data   	= spark.read.jdbc(jdbcUrl, "hadoop.ratings", connectionProperties)
data.createTempView("ratings")
val user = sql(s"SELECT * FROM ratings WHERE id LIKE '$userId'")

//선호 장르
val movie = user.join(movieList, "title").select("id", "title", "genre", "rating").sort($"rating".desc)
val num = (movie.count()*0.05).toInt
val result = movie.groupBy($"genre").agg(count($"genre"), avg($"rating")).filter(s"count(genre) >= $num").sort($"avg(rating)".desc)
val genreList = result.select(lit(userId).as("id"), $"genre", $"count(genre)".as("count"), $"avg(rating)".as("avg"))
genreList.write.mode(SaveMode.Append).jdbc(jdbcUrl, "hadoop.favoriteGenre", connectionProperties)


//선호 배우
val tempList = movieList.select($"product", $"title", $"actor")
val actorList = tempList.withColumn("actor", explode(split($"actor", ","))).filter("actor != ''")

val movie = user.join(actorList, "title").select("id", "title", "actor", "rating").sort($"rating".desc)
val num = (movie.count()*0.01).toInt
val result = movie.groupBy($"actor").agg(count($"actor"), avg($"rating")).filter(s"count(actor) >= $num").sort($"avg(rating)".desc)
val favoriteActor = result.select(lit(userId).as("id"), $"actor", $"count(actor)".as("count"), $"avg(rating)".as("avg"))
favoriteActor.write.mode(SaveMode.Append).jdbc(jdbcUrl, "hadoop.favoriteActor", connectionProperties)

//선호 감독
val tempList = movieList.select($"product", $"title", $"director")
val directorList = tempList.withColumn("director", explode(split($"director", ","))).filter("director != ''")
val movie = user.join(directorList, "title").select("id", "title", "director", "rating").sort($"rating".desc)
val num = 2
val result = movie.groupBy($"director").agg(count($"director"), avg($"rating")).filter(s"count(director) >= $num").sort($"avg(rating)".desc)
val favoriteDirector = result.select(lit(userId).as("id"), $"director", $"count(director)".as("count"), $"avg(rating)".as("avg"))
favoriteDirector.write.mode(SaveMode.Append).jdbc(jdbcUrl, "hadoop.favoriteDirector", connectionProperties)

//선호 
val countryList = movieList.select($"product", $"title", $"country")
val movie = user.join(countryList, "title").select("id", "title", "country", "rating").sort($"rating".desc)
val result = movie.groupBy($"country").agg(count($"country"), avg($"rating")).filter(s"count(country) >= $num").sort($"avg(rating)".desc)
val favoriteCountry = result.select(lit(userId).as("id"), $"country", $"count(country)".as("count"), $"avg(rating)".as("avg"))
favoriteCountry.write.mode(SaveMode.Append).jdbc(jdbcUrl, "hadoop.favoriteCountry", connectionProperties)

System.exit(1)




