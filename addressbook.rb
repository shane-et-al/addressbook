# Addressbook Ruby Tutorial Project
# Author:: Shane Lin (ssl2ab@)

require 'csv'

 # This class holds the data fields for a single addressbook entry
 # !! Verify RDoc formating
 # !! Ruby class, method, varname naming per style guide?  
class Entry
  include Comparable
  
  # Constructor. Or whatever it's called in Ruby
  # *  Parameter must be an array of 4 values
  
  # !! No constructor overloading? Workaround?
  def initialize(params)
    @lname = params[0]
    @fname = params[1]
    @address = params[2]
    @phone = params[3]
  end
  
  def get_name
    @fname + " " + @lname
  end
  
  def get_name_last_first
    @lname + ", " + @fname
  end
  
  def get_address
    @address
  end 
  
  def get_phone
    @phone
  end
  
  def self.get_count
    @@entry_count
  end
  
  def <=> other
    self.get_name_last_first <=> other.get_name_last_first
  end
end

# Container for address book methods
class Addressbook
  def initialize()
    @address_entries = Hash.new
    @entry_count = 0
  end
  
  def load_csv(filename)
    address_raw = File.read(filename)
    csv = CSV.parse(address_raw, :headers => true)
    csv.each do |row|
      entry = Entry.new(row)
      @address_entries[entry.get_name_last_first] = entry
      @entry_count += 1
    end
  end
  
  def get_total
    @entry_count
  end
  
  def get_all_entries
    @address_entries.values
  end
    
end
  

# !! Class init method?
abook = Addressbook.new
abook.load_csv('addresses.csv')

puts "Total: " + abook.get_total.to_s + " entries \n\n"

abook.get_all_entries.each do |entry|
  puts entry.get_name_last_first
end

puts "\n"

abook.get_all_entries.sort.each do |entry|
  puts entry.get_name_last_first
end
