class Utils < ApplicationController

  attr_accessor :all_ratings_h

  def initialize(opts = {})
    thing = opts[:thing]
  end

  def self.ratinghash(all_ratings)
	@all_ratings_h = Hash.new()
	c = 0
	while c < all_ratings.size
		@all_ratings_h.store(all_ratings[c], "1")
		c += 1
	end
	return @all_ratings_h
  end

end

