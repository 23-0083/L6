
class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  helper_method :current_cart

  private

  def current_cart
    if session[:cart_id]
      cart = Cart.find(session[:cart_id])
    else
      cart = Cart.create
      session[:cart_id] = cart.id
    end
    cart
  end
end
