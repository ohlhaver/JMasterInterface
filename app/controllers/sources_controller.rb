class SourcesController < ApplicationController
  
  layout 'scaffold'
  
  def index
    @sources = Source.paginate( :page => params[:page] || 1 )
  end
  
  def update
    @source = Source.find( params[:id ] )
    @source.update_attribute( :default_preference, params[:source][:default_preference] )
    flash[:notice] = 'Updated successfully'
    redirect_to :action => :index
  end
  
end
