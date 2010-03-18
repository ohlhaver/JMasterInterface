class SourcesController < ApplicationController
  
  layout 'scaffold'
  
  def index
    back = params.delete(:back)
    session[:page] = ( back == '1' ? nil : (params[:page] || 1) ) || session[:page] || 1
    session[:s] = ( back == '1' ? nil : (params[:s] || '') ) || session[:s]
    pagination_options = { :page => session[:page], :per_page => 100, :order => 'sources.default_preference DESC, sources.name ASC', :include => [ :source_subscriptions ] }
    @sources = session[:s].blank? ? Source.paginate( pagination_options ) :
      Source.name_like( session[:s] ).paginate( pagination_options )
  end
  
  def update
    @source = Source.find( params[:id ] )
    @source.update_attribute( :default_preference, params[:source][:default_preference] )
    flash[:notice] = 'Updated successfully'
    redirect_to :action => :index, :back => 1
  end
  
end
