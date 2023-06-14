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
    @popular = Movie.where(category: 'popular')
    @bookmark = Bookmark.new
  end

  private

  # def fetch_movies(category)
  #   key = ENV['API_KEY']
  #   url = "https://api.themoviedb.org/3/movie/#{category}?api_key=#{key}&language=en-US&adult=false"
  #   base_poster_url = "https://image.tmdb.org/t/p/w500"
  #   movies = []
  #   3.times do |i|
  #     response = RestClient.get("#{url}&page=#{i + 1}")
  #     data = JSON.parse(response)
  #     result = data['results']
  #     result.map do |movie_hash|
  #       movie = Movie.find_by(title: movie_hash['title'])
  #       if movie
  #         movie.update(
  #           title: movie_hash['title'],
  #           overview: movie_hash['overview'],
  #           poster_url: "#{base_poster_url}#{movie_hash['poster_path']}",
  #           rating: movie_hash['vote_average'].to_f
  #         )
  #         movies << movie
  #       else
  #         movie = Movie.create(
  #           title: movie_hash['title'],
  #           overview: movie_hash['overview'],
  #           poster_url: "#{base_poster_url}#{movie_hash['poster_path']}",
  #           rating: movie_hash['vote_average'].to_f
  #         )
  #         movies << movie
  #       end
  #     end
  #   end
  #   movies
  # end

end
