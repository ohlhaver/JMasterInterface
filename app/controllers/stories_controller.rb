class StoriesController < ApplicationController
  
  layout 'scaffold'
  
  def show
    @story = Story.find( params[:id], :include => [:story_content, :authors, :source] )
    @group = @story.story_groups.current_session.first
    @duplicates = Story.all(  :conditions => 
        [ 'stories.id IN ( SELECT story_id FROM story_metrics 
            WHERE master_id = ? )', @story.id ], 
      :include => [:source] )
  end

end
