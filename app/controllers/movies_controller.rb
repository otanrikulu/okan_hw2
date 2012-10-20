class MoviesController < ApplicationController
# THIS FILE WORKS PERFECTLY FINE LOCALLY, BUT NOT ON HEROKU!..
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      @movies = Movie.find_all_by_rating(@selected_ratings, :order => 'title')
      @title_header = {:order => :title}, 'hilite'
    when 'release_date'
      @movies = Movie.find_all_by_rating(@selected_ratings, :order => 'release_date')
      @release_date_header = {:order => :release_date}, 'hilite'
    end
#    @all_ratings = Movie.ratingcollect
    @all_ratings = ["G", "R", "PG-13", "PG"]
#    @all_ratings = %w(G PG PG-13 NC-17 R)
#    all_ratings_hash = Hash.new()
#    c = 0
#      while c < @all_ratings.size
#      all_ratings_hash.store(@all_ratings[c], "1")
#      c += 1
#    end

    my_ratings = Hash.new()
    all_ratings_hash = Utils.ratinghash(@all_ratings)
#    all_ratings_hash = {"G"=>"1", "R"=>"1", "PG-13"=>"1", "PG"=>"1"}
    @selected_ratings = params[:ratings] || session[:ratings] || all_ratings_hash

    if params[:sort] != session[:sort]
      session[:sort] = sort
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end

    if params[:ratings] != session[:ratings] and @selected_ratings != {}
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    @movies = Movie.find_all_by_rating(@selected_ratings.keys,:order => sort)

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
