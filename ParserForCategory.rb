require_relative 'ParserForProduct'
require_relative 'FileWriter'
require 'nokogiri'
require 'curb'
require  'set'

class ParserForCategory

  $parsed_products = []                                                          #Array with all products

  def initialize(url_page, file_name)
    @url_page = url_page
    @file_name = file_name
  end

  def parse_pages
    elements = search_elements                                                      #Search all elements in a category
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

  def search_elements
    url_page=@url_page
    i=1
    products = []
    loop do
      puts "Copying a category page #{i} (#{url_page})"
      category_page = Nokogiri::HTML(Curl.get(url_page).body_str)
      puts "Search elements on page #{i}."
      products_on_page = category_page.xpath('//ul[@id="product_list"]/li/div[contains(@class, "product-container")]/div/div[contains(@class, "product-desc display_sd")]/a/@href')
      puts "Total elements on page #{i}: #{products_on_page.size}"
      products += products_on_page
      break if (products_on_page.size<25)
      i += 1
      url_page="#{@url_page}?p=#{i}"
    end
    return products
  end

end
