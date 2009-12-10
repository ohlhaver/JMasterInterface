# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :admin_required, :except => [ :logout, :access_denied ]
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  layout 'scaffold'
  
  def logout
    CASClient::Frameworks::Rails::Filter.logout( self, CasServerConfig[RAILS_ENV]['service'] )
  end
  
  def access_denied
    render :template => 'dashboard/access_denied'
  end
  
  protected
  
  def admin_required
    @user ||= User.find_by_id( session[:cas_extra_attributes]['id'], :include => :user_role )
    unless session[:cas_extra_attributes]['id'] && @user && @user.user_role.admin?
      redirect_to access_denied_path
      return false
    end
  end
  
end
