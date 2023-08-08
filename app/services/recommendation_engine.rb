class RecommendationEngine
  def initialize(favorite_movies)
    @favorite_movies = favorite_movies
  end

  def recommendations
    movie_ids = get_movie_ids()
    genres = Movie.where(id: movie_ids).pluck(:genre)
    common_genres = genres.group_by{ |e| e }.sort_by{ |k, v| -v.length }.map(&:first).take(3)
    Movie.where(genre: common_genres).order(rating: :desc).limit(10)
  end

  private

  def get_movie_ids()
    ids = []
    @favorite_movies.each do |movie|
      ids << movie.id
    end
    return ids
  end
end