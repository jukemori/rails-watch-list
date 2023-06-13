class FetchMovie
  # def create_movies(category)
  #   url = "https://api.themoviedb.org/3/movie/#{category}?api_key=344f0f780755bea2b31e065cd88c6cc0&language=en-US&adult=false"
  #   10.times do |i|
  #     puts "Importing movies from page #{i + 1}"
  #     movies = JSON.parse(URI.open("#{url}&page=#{i + 1}").read)['results']
  #     movies.each do |movie|
  #       puts "Creating #{movie['title']}"
  #       base_poster_url = "https://image.tmdb.org/t/p/original"
  #       Movie.create(
  #         title: movie['title'],
  #         overview: movie['overview'],
  #         poster_url: "#{base_poster_url}#{movie['poster_path']}",
  #         rating: movie['vote_average']
  #       )
  #     end
  #   end
  # end
end
