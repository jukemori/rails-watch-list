class BookmarksController < ApplicationController
  def new
    @movies = Movie.all
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create

  if params[:movie_ids].present?
    list_id = params[:list_id]
    movie_ids = params[:movie_ids].split(',')
    movie_ids.each do |movie_id|
      bookmark = Bookmark.new(movie_id: movie_id, list_id: list_id)
      bookmark.save!
    end
    redirect_to list_path(list_id)
  end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
