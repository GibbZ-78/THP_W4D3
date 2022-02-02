# app.rb - Coded with love & sweat by Jean-Baptiste VIDAL for THP Developer curriculum (Winter 2022)
# W4D3 - Exercises of scrapping then storage of results in a JSON, CSV or Google Drive spreadsheet

# Useful includes & requires
require 'bundler'
Bundler.require
require_relative 'lib/apps/scraptownhall.rb'

# main - Main method launching the whole logic of the program
def main
  my_scrapper = Scraptownhall.new
  my_townhall_tab = my_scrapper.create_townhall_hash
  puts my_townhall_tab
end

# Invoke the main method to launch the program
main

# app.rb - Coded with love & sweat by Jean-Baptiste VIDAL for THP Developer curriculum (Winter 2022)