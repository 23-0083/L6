
class CartitemsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @cart_item = CartItem.new
  end

  def create
    product = Product.find(params[:product_id])
    cart_item = current_cart.cart_items.find_or_initialize_by(product: product)
    cart_item.qty = (cart_item.qty || 0) + params[:qty].to_i

    if cart_item.qty > 0 && cart_item.save
      redirect_to cart_path(current_cart), notice: "カートに追加しました"
    else
      redirect_to products_path, alert: "数量を正しく入力してください"
    end
  end

  def destroy
    cart_item = current_cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path(current_cart), notice: "カートから削除しました"
  end
end
