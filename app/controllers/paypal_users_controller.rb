class PaypalUsersController < ApplicationController
  
  layout 'scaffold'
  
  def index
    @paid_by_paypals = PaidByPaypal.paginate( :page => params[:page] || 1, :select => 'paid_by_paypals.*', 
      :include => :user, :order => 'starts_at DESC' )
  end
  
  def new
    @paid_by_paypal = PaidByPaypal.new( :starts_at => Time.now )
  end
  
  def create
    price_hash = { 1 => 395000, 3 => 995000, 6 => 1795000, 12 => 2995000 }
    @paid_by_paypal = PaidByPaypal.new( params[:paid_by_paypal] )
    @paid_by_paypal.payment_status = "Completed"
    @paid_by_paypal.subscription_status = "Manual"
    @paid_by_paypal.item_id = "7123190"
    @paid_by_paypal.amount = price_hash[ @paid_by_paypal.plan_name.to_i ]
    @paid_by_paypal.currency = "EUR"
    if @paid_by_paypal.save
      flash[:notice] = 'Paid by PayPal record created successfully'
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
  
end
