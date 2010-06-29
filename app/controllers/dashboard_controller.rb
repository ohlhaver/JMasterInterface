class DashboardController < ApplicationController
  
  layout 'scaffold'
  
  def index
    @duplicate_checker_queue_size = Story.count( :all, :conditions => { :duplicate_checked => false } )
    @quality_ratings_queue_size = Story.count( :all, :conditions => { :duplicate_checked => true, :quality_ratings_generated => false } )
  end

end
