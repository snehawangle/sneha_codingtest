class ChargesController < ApplicationController
  include ChargesHelper	
  before_action :authenticate_user!

  def index
  	@transactions = Transaction.where("user_id=?",current_user.id)
  end

  def new
    @amount = 10    
  end
 
  def create
    # Amount in cents
    Stripe.api_key = get_stripe_settings[Rails.env]["stripe"]["secret_key"]
    amount = 10.to_i * 100

    # Create the customer in Stripe
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
 
    # Create the charge using the customer data returned by Stripe API
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )    
    #add transaction for user.
    Transaction.create({user_id: current_user.id, amount: amount, transaction_number: params[:stripeToken]})
    flash[:notice] = "Payment of $10 is made successfully."
    redirect_to dashboard_path
    # place more code upon successfully creating the charge
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
    flash[:notice] = "Please try again"
  end	
end
