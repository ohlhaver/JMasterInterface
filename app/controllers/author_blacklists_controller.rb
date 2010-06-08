class AuthorBlacklistsController < ApplicationController
  
  def index
    @blacklists = AuthorBlacklist.paginate( :page => params[:page] || '1' )
    @blacklist = AuthorBlacklist.new
  end
  
  def create
    @blacklist = AuthorBlacklist.new( params[:author_blacklist] )
    if @blacklist.save
      flash[:notice] = 'Added Successfully.'
    else
      flash[:error] = 'Addition Failed.'
    end
    redirect_to :back
  end
  
  def destroy
    @blacklist = AuthorBlacklist.find( params[:id] )
    @blacklist.destroy
    redirect_to :back
  end

end
