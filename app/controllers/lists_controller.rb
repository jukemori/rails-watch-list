require 'rest-client'

class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  def index
    @lists = List.all
    # @movies = Movie.order(:id).limit(20)
    @now_playing = Movie.where(category: 'now_playing').order(:id).limit(20)
    @top_rated = Movie.where(category: 'top_rated').order(:id).limit(20)
    @upcoming = Movie.where(category: 'upcoming').order(:id).limit(20)
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

  # def fetch_movies(category)
  #   key = ENV['API_KEY']
  #   url = "https://api.themoviedb.org/3/movie/#{category}?api_key=#{key}&language=en-US&adult=false"
  #   base_poster_url = "https://image.tmdb.org/t/p/w500"
  #   movies = []
  #   1.times do |i|
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

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name,:photo)
  end
end
