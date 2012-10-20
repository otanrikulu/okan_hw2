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
	@selected_ratings = params[:ratings] || session[:ratings] || {}
	@my_session_sort = session[:sort]
	@my_session_rating = session[:ratings]


#	if @ratingselection == {} then
#		@ratingselection = @all_ratings
#	else @ratingselection = params[:ratings]
#	end
	
	case sort
	when 'title'
		@movies = Movie.find(:all, :order => 'title')
#		@movies = Movie.find_all_by_rating(@selected_ratings, :order => 'title')
		@title_header = {:order => :title}, 'hilite'
	when 'release_date'
		@movies = Movie.find(:all, :order => 'release_date')
#		@movies = Movie.find_all_by_rating(@selected_ratings, :order => 'release_date')
		@release_date_header = {:order => :release_date}, 'hilite'
	else
		@movies = Movie.all
	end

#	if params[:sort] != session[:sort]
#		session[:sort] = sort
#		redirect_to :sort => sort, :ratings => @ratingselection and return
#	end	
#	if params[:ratings] != session[:ratings] and @ratingselection != {}
#      		session[:sort] = sort
#      		session[:ratings] = @ratingselection
#      		redirect_to :sort => sort, :ratings => @ratingselection and return
#	end	
#	@movies = Movie.find_all_by_rating(@ratingselection.keys, Movie.find(:all, :order => 'title'))

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
