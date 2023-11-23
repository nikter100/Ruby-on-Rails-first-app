class CopyPrice < ActiveRecord::Migration[5.1]
  def total_price
    price = product(product_id :price) 

    @price = price.CopyPrice
  end
end
