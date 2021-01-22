require_relative 'ParserForProduct'
require_relative 'FileWriter'
require 'nokogiri'
require 'curb'

class ParserForCategory

  def initialize(url_page, file_name)
    @url_page = url_page
    @file_name = file_name
  end

  def parse_pages
    $parsed_products = []                                                         #Array with all products
    print "Copying a category page... "
    puts @url_page
    category_page = Curl.get(@url_page)
    puts "Ok!!!"
    print "Find elements...  "
    category_doc = Nokogiri::HTML(category_page.body_str)
    elements = category_doc.xpath('//ul[@id="product_list"]/li/div[contains(@class, "product-container")]/div/div[contains(@class, "product-desc display_sd")]/a/@href')
    puts "Elements found in category: #{elements.size}"
    puts "Let's start parsing elements... "
    elements.each_with_index do |product, i|
      print "Parsing #{i+1} element out of #{elements.size}"
      if (i<=elements.length)
        print "\r"
      else
        print "\n"
      end
      ProductPagesParser.new(product).parse_product                               #Parsing product page
    end
    puts "\nParsing finished. Total found #{$parsed_products.size} products."
    FileWriter.new(@file_name).write_to_csv                                       #Writing CSV file
  end

end
