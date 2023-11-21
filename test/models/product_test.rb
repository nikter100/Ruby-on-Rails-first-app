require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end
  test "product attributes must not be empty" do 
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any? 
    assert product.errors[:price].any? 
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "My Book Title",
                          description: "yyy",
                          )
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]

    product.price > 1
    assert product.invalid?
  end

  def new_product(image_url) 
    Product.new(title: "My Book Title",
                description: "yyy", price: 1, 
                image_url: image_url)
  end
  
  test "product image url" do 
    ok = %w{ image.jpg image.png image.gif IMAGE.JPG IMAGE.Png}

    bad = %w{ image.doc image.gif/more image.gif.more}

    ok.each do |image_url|
      assert new_product(image_url).valid?,
            "#{image_url} shouldn't be invalid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?,
            "#{image_url} shouldn't be valid"
    end
  end

  test "prtoduct title must be unqiue" do 
    product = Product.new(
                title: products(:rubs).title,
                description: "yyy",
                price: 1,
                image_url: "image.gif")
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                  product.errors[:title]
  end
end
=begin
test "product attributes must not be empty" do
  product = Product.new
  assert product.invalid?
  assert product.errors[:title].any?
  assert product.errors[:description].any? 
  assert product.errors[:price].any? 
  assert product.errors[:image_url].any?
end
=end
def new_product(image_url) 
  Product.new(
    title: "My Book Title",
    description: "yyy", 
    price: 1, 
    image_url: image_url)
end
test "image url" do
  ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
            http://a.b.c/x/y/z/fred.gif }
  bad = %w{ fred.doc fred.gif/more fred.gif.more }

  ok.each do |image_url|
    assert new_product(image_url).valid?,
      "#{image_url} shouldn't be invalid"
  end
  bad.each do |image_url|
    assert new_product(image_url).invalid?,
          "#{image_url} shouldn't be valid"
  end 
end
    