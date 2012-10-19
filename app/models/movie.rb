class Movie < ActiveRecord::Base
  def self.ratingcollect
	@all_ratings = Movie.all(:select => 'rating').map(&:rating).uniq
  end
end
