class StoryGroupsController < ApplicationController
  
  layout 'scaffold'
  
  def index
    @story_groups = StoryGroup.current_session.paginate( :page => params[:page] || '1', :include => [ :language ] )
    populate_stories_to_serialize( nil, @story_groups, 1) 
  end

  def show
    @story_group = StoryGroup.find( params[:id] )
    @stories = @story_group.stories.paginate( :page => params[:page] || '1', :include => :story_metric )
  end

end
