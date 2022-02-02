# storage.rb - Coded with love by JBV for THP "Développeur" (Hiver 2022)

# Useful includes
require_relative 'scraptownhall.rb'

# Storage - Class offering 3 differents ways to store an array of hash (previously generated)
#         > Possible improvement: what if I also make this class a specialization of the Array class ?
class Storage < Scraptownhall
  # Class var
  @@storage_format_tab = ["JSON", "CSV", "GDRIVE"]

  # Instance var
  attr_accessor :storage_mode

  # initialize - Instance creator called via ".new(format)" where format is "JSON","CSV","GDRIVE"
  def initialize(storage_format)
    if !@@storage_format_tab.index(storage_format).nil?
      @storage_mode = @@storage_format_tab[@@storage_format_tab.index(storage_format)]
    else
       @storage_mode = ""
    end
  end

  # save_as_json - Instance method storing the array passed as a parameter into the named JSON file
  def save_as_json(my_tab_of_hash, my_json_filename)
    puts
    puts "Saving scrapped content into a JSON file:"
    tmp_data = JSON.pretty_generate(my_tab_of_hash)
    puts "  > Scrapped data tranformed into a JSON object."
    puts "  > Saving JSOn object into a JSON file."
    if File.exists?(my_json_filename)
      puts "  > File '#{my_json_filename}' exists already - Overwriting it."
      File.write(my_json_filename, tmp_data)
    else
      puts "  > File '#{my_json_filename}' does not exist - Creating and opening it in R/W mode."
      tmp_file = File.open(my_json_filename, "w")
      tmp_file.write(tmp_data)
      tmp_file.close
    end
    puts "  > JSON file filled in and saved."
    puts
  end

  # save_as_csv - Instance method storing the array passed as a parameter into the named CSV file
  def save_as_csv(my_tab_of_hash, my_csv_filename)
    tmp_content = ""
    tmp_count = 0
    puts
    puts "Saving scrapped content into a CSV file:"
    puts "  > Searching for backup file."
    if File.exists?(my_csv_filename)
      puts "  > File '#{my_csv_filename}' exists already - Overwriting it."
      my_tab_of_hash.each do |hash| 
        tmp_content += "'#{hash.keys[0]}','#{hash[hash.keys[0]]}'\n"
        tmp_count += 1
      end
      File.write(my_csv_filename, tmp_content)
    else
      puts "  > File '#{my_csv_filename}' does not exist - Creating and opening it in R/W mode."
      tmp_file = File.open(my_csv_filename, "w")
      my_tab_of_hash.each do |hash|
        tmp_content += "'#{hash.keys[0]}','#{hash[hash.keys[0]]}'\n"
        tmp_count += 1
      end
      tmp_file.write(tmp_content)
      tmp_file.close
      puts "  > Closing file."
    end
    puts "  > #{tmp_count} lines written into the CSV file."
    puts
  end

  
  # OLD SHIT - THP pedagogical resources being, as (too) often, largely obsolete
  # save_as_spreadsheet - Instance method storing the array passed as a parameter into the named (existing) Google spreadsheet on gDrive
  def save_as_spreadsheet(my_tab_of_hash, my_spreadsheet_key)
    tmp_line_pointer = 1
    tmp_count = 0
    puts
    puts "Saving scrapped content into a Google spreadsheet:"
    puts "  > Opening gDrive session."
    my_gdrive_session = GoogleDrive::Session.from_config("private/config_old.json")
    puts "  > Accessing existing spreadsheet by 'key identifier'."
    my_worksheet = my_gdrive_session.spreadsheet_by_key(my_spreadsheet_key).worksheets[0]
    puts "  > Parsing array of hashes and writing key into 'A*' cell and value into 'B*' cell."
    my_tab_of_hash.each do |hash|
      my_worksheet[tmp_line_pointer,1] = hash.keys[0]
      my_worksheet[tmp_line_pointer,2] = hash[hash.keys[0]]
      tmp_line_pointer += 1
      tmp_count += 1
    end
    puts "  > #{tmp_count} lines written into the spreadsheet."
    my_worksheet.save
    puts "  > Saving spreadsheet."
    my_worksheet.reload
    puts "  > Reloading spreadsheet to refresh content brought by other simultaneous users."
  end

  # OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
  # APPLICATION_NAME = "Google Sheets API Ruby Quickstart".freeze
  # CREDENTIALS_PATH = "credentials.json".freeze
  # # The file token.yaml stores the user's access and refresh tokens, and is
  # # created automatically when the authorization flow completes for the first
  # # time.
  # TOKEN_PATH = "token.yaml".freeze
  # SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY


  # read_from_json - Instance method reading a JSON file, then translating and returning it into the array of hash of a Storage object
  def read_from_json(my_json_filename)
    
  end

  # read_from_csv - Instance method reading a CSV file, then translating and returning it into the array of hash of a Storage object
  def read_from_csv(my_csv_filename)

  end

  # read_from_spreadsheet - Instance method reading a Google spreadsheet, then translating and returning it into the array of hash of a Storage object
  def read_from_spreadsheet(my_spreadsheet_filename)

  end

end

# storage.rb - Coded with love by JBV for THP "Développeur" (Hiver 2022)

