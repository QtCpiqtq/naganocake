class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "作成に成功しました。"
      redirect_to genres_path
    else
      @genres = Genre.all
      flash.now[:alert] = "作成に失敗しました。"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to genres_path
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
