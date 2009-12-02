class AuthorAliasesController < ApplicationController
  
  def update
    @author_alias = AuthorAlias.find(params[:id])
    if @author_alias.update_attributes( params[:author_alias] )
      @success = "Updated Successfully"
    end
    render :update do |page|
      page.replace "author_alias_#{@author_alias.id}", :partial => 'show'
    end
  end
  
  def create
    @author_alias = AuthorAlias.new( params[:author_alias] )
    if @author_alias.save
      render :update do |page|
        @success = "Created Successfully"
        page.insert_html :bottom, 'author_aliases', :partial => 'show'
        @author_alias = AuthorAlias.new( :author_id => @author_alias.author_id )
        @success = nil
        page.replace 'new_author_alias', :partial => 'form'
      end
    else
      @author = Author.find_or_initialize_by_name( @author_alias.name )
      render :update do |page|
        if @author.id != @author_alias.author_id && !@author.new_record?
          @success = "Author already exists. #{link_to( 'Merge', merge_author_url( :id => @author_alias.author_id, :s => @author.name ) )}"
          @author_alias.errors.clear
        end
        page.replace 'new_author_alias', :partial => 'form'
      end
    end
  end
  
  def destroy
    @author_alias = AuthorAlias.find(params[:id])
    @author_alias.destroy
    if @author_alias.frozen?
      render :update do |page|
        page.remove "author_alias_#{@author_alias.id}"
      end
    else
      @success = "Delete Operation Failed."
      render :update do |page|
        page.replace "author_alias_#{@author_alias.id}", :partial => 'show'
      end
    end
  end
  
end
