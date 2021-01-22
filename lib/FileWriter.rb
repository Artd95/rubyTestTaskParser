require 'csv'

class FileWriter

  def initialize(file_name)
    @file_name = file_name
  end

  def write_to_csv
    puts "Recording to a CSV file..."
    headers = ["Name", "Price", "Image"]                                                  #Header CSV file
    CSV.open(@file_name, "w", write_headers: true, headers: headers) do |csv|             #Open CSV file  for writing with header row
      $parsed_products.each do |product|
         csv << [product.product_name, product.product_price, product.image_link]         #Record products
      end
    end
    puts "Recording finished!"
  end

end