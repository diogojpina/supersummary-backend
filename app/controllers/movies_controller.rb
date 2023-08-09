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
    
    if (movie.available_copies <= 0)
      render :json => { :errors => "Unavailable movie!" }, :status => 400
      return
    end

    movie.available_copies -= 1
    movie.save
    user.rented << movie
    render json: movie
  end

  def return
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
    
    rental_found = false
    user.rentals.each do |rental|
      if rental.movie.id == movie.id && !rental.returned
        puts rental.movie.id
        puts DateTime.now
        rental.returned = DateTime.now
        rental.save

        movie.available_copies -= 1
        movie.save

        rental_found = true
        break
      end
    end  

    if rental_found == false
      render :json => { :errors => "Rental not found." }, :status => 400
      return
    end

    render json: movie
  end
end