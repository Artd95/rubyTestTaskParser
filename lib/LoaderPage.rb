
class LoaderPage

  def initialize(page_url, file_name)
    @page_url = page_url
    @file_name = file_name
    puts 'Rfbjrjfm'
  end

  def load_page
    page = Curl.get(@page_url)
    page.body_str
  end

end
