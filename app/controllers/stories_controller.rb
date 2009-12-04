class StoriesController < ApplicationController
  
  layout 'scaffold'
  
  def show
    @story = Story.find( params[:id], :include => [:story_content, :authors] )
    @group = @story.story_groups.current_session.first
  end

end
