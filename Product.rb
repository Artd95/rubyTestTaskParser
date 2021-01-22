class Product

  attr_accessor :product_name, :product_price, :image_link

  def initialize(args)
    @product_name = args[0]
    @product_price = args[1]
    @image_link = args[2]
  end

end
