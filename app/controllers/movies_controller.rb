require 'rest-client'

class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order(:id)
    if params[:query].present?
      sql_subquery = "title ILIKE :query OR overview ILIKE :query"
      @movies = @movies.where(sql_subquery, query: "%#{params[:query]}%")
    end
    @bookmark = Bookmark.new
  end

  def show
    @movie = Movie.find(params[:id])
    @movies = Movie.where.not(id: @movie.id).order(:id).limit(20)
    @popular = fetch_movies('now_playing')
    @bookmark = Bookmark.new
  end

  private

  def fetch_movies(category)
  token = ENV['ACCESS_TOKEN']
  url = URI("https://api.themoviedb.org/3/movie/#{category}?language=en-US&page=1")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["accept"] = 'application/json'
  request["Authorization"] = "Bearer #{token}"

  response = http.request(request)
  data = JSON.parse(response.read_body)

  base_poster_url = "https://image.tmdb.org/t/p/w500"
  movies = []

  data["results"].each do |movie_hash|
    movie = Movie.find_by(title: movie_hash['title'])

    if movie
      movie.update(
        title: movie_hash['title'],
        overview: movie_hash['overview'],
        poster_url: "#{base_poster_url}#{movie_hash['poster_path']}",
        rating: movie_hash['vote_average'].to_f
      )
    else
      movie = Movie.create(
        title: movie_hash['title'],
        overview: movie_hash['overview'],
        poster_url: "#{base_poster_url}#{movie_hash['poster_path']}",
        rating: movie_hash['vote_average'].to_f
      )
    end

    movies << movie
  end

  movies
  end

end
