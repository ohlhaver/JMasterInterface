class PaypalUsersController < ApplicationController
  
  layout 'scaffold'
  
  def index
    @paid_by_paypals = PaidByPaypal.paginate( :page => params[:page] || 1, :select => 'paid_by_paypals.*, MAX(starts_at) AS starts_at, MAX(ends_at) AS ends_at', 
      :include => :user, :group => 'user_id', :order => 'starts_at DESC' )
  end
  
end
