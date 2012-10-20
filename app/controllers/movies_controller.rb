class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

#    @all_ratings = Movie.all(:select => 'rating').map(&:rating).uniq
#    This is working. Now, let's define a method in Movie.

    @sortorder = params[:sort] || session[:sort]
    @all_ratings = Movie.ratingcollect #reads all available ratings from the table

    @my_session_sort = session[:sort]
    @my_params_sort = params[:sort]
    @my_session_rating = session[:ratings]
    @my_params_rating = params[:ratings]

# Check out Hash to Hash assignments...
    @ratingselection = params[:ratings] || @all_ratings

	if @ratingselection == @all_ratings then
		@all_ratings_h = Hash.new{}
		c = 0
		while c < @all_ratings.size
		@all_ratings_h.store(@all_ratings[c], "1")
		c += 1
		end
		@ratingselection = @all_ratings_h
	
	end

#	@movies = Movie.find(:all)
	case @sortorder
	when 'title'
#		@checked_ratings = @ratingselection.keys
#		@movies = Movie.find(:all, :order => 'title')
		@okan = 11111
		@movies = Movie.find_all_by_rating(@ratingselection.keys, :order => 'title')
		@title_header = {:order => :title}, 'hilite'
	when 'release_date'
#		@checked_ratings = @ratingselection.keys
#		@movies = Movie.find(:all, :order => 'release_date')
		@okan = 22222
		@movies = Movie.find_all_by_rating(@ratingselection.keys, :order => 'release_date')
		@release_date_header = {:order => :release_date}, 'hilite'
#	else
#		@checked_ratings = @ratingselection
#		@movies = Movie.find_all_by_rating(@all_ratings_h.keys)
#		@movies = Movie.find_all_by_rating(@ratingselection.keys)
	end
	
	if params[:ratings] != session[:ratings] and @ratingselection != {}
		session[:sort] = @sortorder
		session[:ratings] = @ratingselection
		redirect_to :sort => @sortorder, :ratings => @ratingselection and return
	end
#	@movies = Movie.find_all_by_rating(@ratingselection)


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
