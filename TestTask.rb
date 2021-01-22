require_relative 'ParserForCategory'
require_relative 'Helper'

page_url = ARGV[0]
file_name = ARGV[1]

print_memory_usage do
  print_time_spent do
    puts "Script started at : " + Time.now.inspect
    ParserForCategory.new(page_url, file_name).parse_pages
    puts "Script finished at : " + Time.now.inspect
  end
end