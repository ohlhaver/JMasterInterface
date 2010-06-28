class StoriesController < ApplicationController
  
  layout 'scaffold'
  
  def show
    @story = Story.find( params[:id], :include => [:story_content, :authors, :source] )
    @group = @story.story_groups.current_session.first
    story_metrics = StoryMetric.find( :all, :conditions => { :master_id => @story.id }, :include => { :stories => :source } )
    @duplicates = story_metrics.collect( &:story )
    # @duplicates = Story.all(  :conditions => 
    #     [ 'stories.id IN ( SELECT story_id FROM story_metrics 
    #         WHERE master_id = ? )', @story.id ], 
    #   :include => [:source] )
  end

end
