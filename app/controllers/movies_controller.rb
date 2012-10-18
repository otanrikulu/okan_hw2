class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

	sort = params[:sort]
     
#     sort = params[:sort] || session[:sort]
#	case sort
#	when 'title' then @title_header = {:order => :title}, 'hilite'
#    when 'release_date'
#      ordering,@date_header = {:order => :release_date}, 'hilite'
#	end

#     @movies = Movie.all
#     if 'title' then 
#        @title_header = {:order => :title}, 'hilite'
#     end
#    if 'title' then
#	Movie.find(:all, :order => 'title')
#   end

	case sort
	when 'title'
		@movies = Movie.find(:all, :order => 'title')
		@title_header = {:order => :title}, 'hilite'
	when 'release_date'
		@movies = Movie.find(:all, :order => 'release_date')
		@release_date_header = {:order => :release_date}, 'hilite'
	else
		@movies = Movie.all
	end

#	if sort then
#		@movies = Movie.find(:all, :order => 'title')
#		@title_header = {:order => :title}, 'hilite'
#	else
#		@movies = Movie.all
#	end    
    
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
