class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    if params[:query].present?
      sql_subquery = "title ILIKE :query OR overview ILIKE :query"
      @movies = @movies.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @movies = Movie.where.not(id: @movie.id).order(:id).limit(20)
  end
end
