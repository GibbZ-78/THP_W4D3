
# scraptownhall.rb - Coded with love by JBV for THP "Développeur" (Hiver 2022)

# Useful includes
# NONE! Thanks to 'Bundler'

# Scraptownhall - Class scrapping the mail address of each townhall of the "Vald d'Oise" state
class Scraptownhall

  # Class vars containing URIs to be scrapped
  #   > Possible improvement #1: have these collected as arguments of the "app.rb" when launched by the user
  #   > Possible improvement #2: have these input prompted to the user
  @@url1 = "https://www.annuaire-des-mairies.com/val-d-oise.html"
  @@url2 = "https://www.annuaire-des-mairies.com/95/"

  # Instance vars used to store the intermediary scrapped data and the final "table of hashes"
  attr_accessor :my_townhall_name, :my_townhall_mail, :my_townhall_tab

  # initialize - Instance creator method invoked by ".new()"
  def initialize
    @my_townhall_name = []
    @my_townhall_mail = []
    @my_townhall_tab = []
  end

  #  - Instance method building
  def create_townhall_hash
    puts
    puts "Collecting city name and mail of each city hall of the state"
    print "  > Progress"
    # Cycling through cities' URLs to get and store their respective name and city hall' e-mail address
    Scraptownhall.get_cities_urls(@@url1).each do |city|
      self.my_townhall_name.push(city[0])
      self.my_townhall_mail.push(Scraptownhall.get_townhall_mail(city[1]))
      print "."
    end
    puts
    puts
    print "Building hash from gathered names and mails"
    print "  > Progress"
    # Cycling through the tab of cities then building a table of {name, mail}
    for i in 0...self.my_townhall_name.length do
      my_townhall_hash = Hash.new
      my_townhall_hash[self.my_townhall_name[i]] = self.my_townhall_mail[i] # On pourrait transformer les clés String en Symbols
      self.my_townhall_tab.push(my_townhall_hash)
      print "."
    end
    puts
  end

  private

  # get_townhall_mail - Private class method - Based on the URL of a given city hall, return the related mail address
  def self.get_townhall_mail(townhall_url)
    page_townhall = Nokogiri::HTML(URI.open(townhall_url))
    scrapped_mail = page_townhall.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    return scrapped_mail
  end

  # get_cities_urls - Private class method - Given the base URL of a French department (here "95"), return the URls of all related cities
  def self.get_cities_urls(base_url)
    tab_cities_urls = []
    page_base = Nokogiri::HTML(URI.open(base_url))
    scrap_townhall = page_base.xpath("//*/a[@class='lientxt']") # version simplifiée
    scrap_townhall.each do |lien|
      lien1 = lien.text.downcase.gsub(" ","-")
      tab_cities_urls.push([lien1, @@url2+lien1+".html"]) 
    end
    return tab_cities_urls
  end

end

# scraptownhall.rb - Coded with love by JBV for THP "Développeur" (Hiver 2022)