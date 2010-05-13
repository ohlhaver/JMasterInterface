class AuthorsController < ApplicationController
  
  layout 'scaffold'
  
  def index
    filter = params[:a] != '1' ? nil : { :is_agency => true }
    @authors = Author.search( params[:s] || '', :with => filter, :order => :name, :page => params[:page] || '1', :include => :aliases )
    @story_counts = StoryAuthor.count(:all, :conditions => { :author_id => @authors.collect{ |x| x.try(:id) }  }, :group => 'author_id' )
  end
  
  def todos
    @priority_authors = PriorityAuthor.paginate( :page => params[:page] || 1, :conditions => { :checked => false }, :order => 'updated_at DESC', :include => :author )
  end
  
  def block
    @author = Author.find( params[:id] )
    @author.block!
    redirect_to request.referer || { :action => :index }
  end
  
  def unblock
    @author = Author.find( params[:id] )
    @author.unblock!
    redirect_to request.referer || { :action => :index }
  end
  
  def check
    PriorityAuthor.checked( params[:id] )
    redirect_to request.referer || { :action => :todos }
  end
  
  def show
    @author = Author.find( params[:id] )
    @stories = Story.search( :with => { :author_ids => @author.id }, :page => params[:page] || 1, :include => :source )
  end
  
  def merge
    @author = Author.find( params[:id] )
    if request.post?
      @to_be_merged_authors = Author.find( params[:author_ids] )
      @author.merge_authors( @to_be_merged_authors )
      redirect_to edit_author_path( @author )
    else
      filter = params[:a] != '1' ? nil : { :is_agency => true }
      params[:s] ||= @author.name.split(' ').last
      @authors = Author.search( params[:s], :with => filter, :page => params[:page] || '1', :without => { :author_id => @author.id }, :include => :aliases )
      @story_counts = StoryAuthor.count(:all, :conditions => { :author_id => @authors.collect{ |x| x.try(:id) }  }, :group => 'author_id' )
    end
  end
  
  def split
  end
  
  def edit
    @author = Author.find( params[:id] )
  end
  
  def update
    @author = Author.find( params[:id] )
    if @author.update_attributes( params[:author] ) 
      flash[:notice] = 'Updated Successfully'
      redirect_to edit_author_path( @author )
    else
      render :action => :edit
    end
  end
  
end
