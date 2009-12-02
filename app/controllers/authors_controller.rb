class AuthorsController < ApplicationController
  
  layout 'scaffold'
  
  def index
    filter = params[:a] != '1' ? nil : { :is_agency => true }
    @authors = Author.search( params[:s] || '', :with => filter, :order => :name, :page => params[:page] || '1', :include => :aliases )
    @story_counts = StoryAuthor.count(:all, :conditions => { :author_id => @authors.collect{ |x| x.id }  }, :group => 'author_id' )
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
      @story_counts = StoryAuthor.count(:all, :conditions => { :author_id => @authors.collect{ |x| x.id }  }, :group => 'author_id' )
    end
  end
  
  def split
    #@author = Author.find( params[:id] )
    #if request.post?
    #  @authors = Author.find( params[:id] )
    #end
  end
  
  def edit
    @author = Author.find( params[:id] )
  end
  
end
