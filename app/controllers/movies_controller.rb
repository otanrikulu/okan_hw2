class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

#	@all_ratings = Movie.all(:select => 'rating').map(&:rating).uniq
#	This is working. Now, let's define a method in Movie.

	sort = params[:sort]
	@all_ratings = Movie.ratingcollect #reads all available ratings from the table
#	@ratingselection = params[:ratings] || session[:ratings] || {}
#	@ratingselection = @all_ratings
	@my_session_sort = session[:sort]
	@my_params_sort = params[:sort]
	@my_session_rating = session[:ratings]
	@my_params_rating = params[:ratings]

#	if @ratingselection == {} then
#		@ratingselection = @all_ratings
#	else @ratingselection = params[:ratings]
#	end

	@ratingselection = params[:ratings] || @all_ratings
#	@ratingselection = params[:ratings] || session[:ratings] || {}
#	if @ratingselection == (params[:ratings] || session[:ratings] || {}) then
#		@ratingsselection
#	else
#		@ratingselection = @all_ratings
#	end

	case sort
	when 'title'
#		@checked_ratings = @ratingselection.keys
#		@movies = Movie.find(:all, :order => 'title')
		@movies = Movie.find_all_by_rating(@ratingselection, :order => 'title')
#		@movies = Movie.find_all_by_rating(@checked_ratings, :order => 'title')
		@title_header = {:order => :title}, 'hilite'
	when 'release_date'
#		@checked_ratings = @ratingselection.keys
#		@movies = Movie.find(:all, :order => 'release_date')
		@movies = Movie.find_all_by_rating(@ratingselection, :order => 'release_date')
#		@movies = Movie.find_all_by_rating(@checked_ratings, :order => 'release_date')
		@release_date_header = {:order => :release_date}, 'hilite'
	else
		@checked_ratings = @ratingselection.keys
		@movies = Movie.find_all_by_rating(@checked_ratings)
#		@movies = Movie.find_all_by_rating(@ratingselection)
	end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
