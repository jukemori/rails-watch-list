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
  end
end
