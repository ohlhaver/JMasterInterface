class StoryGroupsController < ApplicationController
  
  def index
    @story_groups = StoryGroup.current_session.paginate( :page => params[:page] || '1', :include => [ :language, :top_story ] )
  end

  def show
    @story_group = StoryGroup.find( params[:id] )
    @stories = @story_group.stories.paginate( :page => params[:page] || '1' )
  end

end
