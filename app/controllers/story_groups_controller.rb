class StoryGroupsController < ApplicationController
  
  layout 'scaffold'
  
  def index
    @story_groups = StoryGroup.current_session.paginate( :page => params[:page] || '1', :include => [ :language ] )
    StoryGroup.populate_stories_to_serialize( nil, @story_groups, 1) 
  end

  def show
    @story_group = StoryGroup.find( params[:id] ) rescue StoryGroupArchive.find( params[:id] )
    @stories = @story_group.stories.paginate( :page => params[:page] || '1', :include => [ :source ] )
    @duplicates = StoryMetric.find(:all, :select => 'master_id, COUNT(*) AS count', :conditions => { :master_id => @stories.collect(&:id) }, :group => :master_id).inject({}){
      |s,x| s.merge!( x.master_id => x.send(:read_attribute, :count ))
    }
  end

end
