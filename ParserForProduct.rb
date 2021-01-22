require_relative 'Product'
require 'nokogiri'
require 'csv'

class ProductPagesParser

  def initialize(page_for_parse)
    @page_for_parse = page_for_parse
  end

  def parse_product
    page = Curl.get(@page_for_parse)                                                               # Copying product page
    doc = Nokogiri::HTML(page.body_str)
    # if (doc.xpath("//div[contains(@class,'attribute_list')]/ul").empty?)
    #   @product_name = doc.xpath("//h1[contains(@class, 'product_main_name')]/text()")
    #   @product_price = doc.xpath("//span[contains(@id,'our_price_display')]/text()")
    #   @image_link = doc.xpath("//img[contains(@id,'bigpic')]/@src")
    #   $parsed_products.push(Product.new([@product_name, @product_price, @image_link]))
    # else
    product_name = "#{doc.xpath("//h1[contains(@class, 'product_main_name')]/text()")} - "
    image_link = doc.xpath("//img[contains(@id,'bigpic')]/@src")
    rezult = doc.xpath("//div[contains(@class,'attribute_list')]/ul/li/label/span[contains(@class,'radio_label')]/text()")
    rezult.each_with_index do |product,i|                                                           #The loop iterates multi-products
      product_name_with_param = "#{product_name}#{doc.xpath("//div[contains(@class,'attribute_list')]/ul/li[#{i+1}]/label/span[contains(@class,'radio_label')]/text()")}"
      product_price = doc.xpath("//div[contains(@class,'attribute_list')]/ul/li[#{i+1}]/label/span[2]/text()")
      $parsed_products.push(Product.new([product_name_with_param, product_price, image_link]))              # Save product to array
    end
    # end
  end

end
