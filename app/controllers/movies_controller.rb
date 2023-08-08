class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies
  end

  def recommendations
    begin
      user = User.find(params[:user_id])    
    rescue
      render :json => { :errors => "User not found! Send a valid user_id." }, :status => 400
      return
    end

    favorite_movies = user.favorites
    recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: recommendations
  end

  def user_rented_movies
    begin
      user = User.find(params[:user_id])    
    rescue
      render :json => { :errors => "User not found! Send a valid user_id." }, :status => 400
      return
    end

    rented = user.rented
    render json: rented
  end

  def rent
    begin
      user = User.find(params[:user_id])    
    rescue
      render :json => { :errors => "User not found! Send a valid user_id." }, :status => 400
      return
    end

    begin
      movie = Movie.find(params[:id])
    rescue
      render :json => { :errors => "Movie not found! Send a valid movie_id." }, :status => 400
      return
    end    
    
    movie.available_copies -= 1
    movie.save
    user.rented << movie
    render json: movie
  end
end