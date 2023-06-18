require 'rest-client'

class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  def index
    @lists = List.all
    # @movies = Movie.order(:id).limit(20)
    @now_playing = fetch_movies('now_playing')
    @top_rated = fetch_movies('top_rated')
    @upcoming = fetch_movies('upcoming')
    @bookmark = Bookmark.new
    @list = List.new
  end

  def show
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      redirect_to list_path(@list)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, status: :see_other
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




  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name,:photo)
  end
end
