class StoreController < ApplicationController
  before_action :increment_counter, only: :index

  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)
    @show_count = "You been here #{session[:counter]} times" if session[:counter] > 5
  end

  private

  def increment_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end
end
