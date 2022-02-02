# app.rb - Coded with love & sweat by Jean-Baptiste VIDAL for THP Developer curriculum (Winter 2022)
# W4D3 - Exercises of scrapping then storage of results in a JSON, CSV or Google Drive spreadsheet

# Useful includes & requires
require 'bundler'
Bundler.require
require_relative 'lib/apps/scraptownhall.rb'
require_relative 'lib/apps/storage.rb'

# main - Main method launching the whole logic of the program
def main
  my_scrapper = Scraptownhall.new
  my_scrapper.create_townhall_hash
  # puts
  # puts "[DEBUG MODE: ON]"
  # puts
  # puts my_scrapper.my_townhall_tab
  # puts
  # puts "[DEBUG MODE: OFF]"
  # puts
  my_json_storage = Storage.new("JSON")
  my_csv_storage = Storage.new("CSV")
  my_gdrive_storage = Storage.new("GDRIVE")
  my_json_storage.my_townhall_tab = my_scrapper.my_townhall_tab
  my_csv_storage.my_townhall_tab = my_scrapper.my_townhall_tab
  my_gdrive_storage.my_townhall_tab = my_scrapper.my_townhall_tab
  # puts
  # puts "[DEBUG MODE: ON]"
  # print "Object: #{my_json_storage} - #Mails: #{my_json_storage.my_townhall_tab.length} - Storage mode: #{my_json_storage.storage_mode}"
  # puts
  # print "Object: #{my_csv_storage} - #Mails: #{my_csv_storage.my_townhall_tab.length} - Storage mode: #{my_csv_storage.storage_mode}"
  # puts
  # print "Object: #{my_gdrive_storage} - #Mails: #{my_gdrive_storage.my_townhall_tab.length} - Storage mode: #{my_gdrive_storage.storage_mode}"
  # puts
  # puts "[DEBUG MODE: OFF]"
  # puts
  my_json_storage.save_as_json(my_json_storage.my_townhall_tab, "db/emails.json")
  my_csv_storage.save_as_csv(my_csv_storage.my_townhall_tab, "db/emails.csv")
  my_gdrive_storage.save_as_spreadsheet(my_gdrive_storage.my_townhall_tab, "")

end

# Invoke the main method to launch the program
main

# app.rb - Coded with love & sweat by Jean-Baptiste VIDAL for THP Developer curriculum (Winter 2022)