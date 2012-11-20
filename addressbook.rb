# Addressbook Ruby Tutorial Project
# Author:: Shane Lin (ssl2ab@)
require 'csv'

# Mixin for formatting

# !! where should this static utility code actually go?
class Formatting
  # Formats cononical name string from lname and fname
  def self.formatName(lname, fname)
    lname + ", " + fname
  end
  
  def self.equalTab(length)
    "\t"*(4-length/8)
  end
end 

# Mixin for name
module EntryName
  
  def set_lname(lname)
    @lname = lname    
  end
  def set_fname(fname)
    @fname = fname    
  end
  
  def get_name
    @fname + " " + @lname
  end
  
  def get_name_last_first
    Formatting.formatName(@lname,@fname)
  end
end

# Mixin for address
module EntryAddress
  def set_address(address)
    @address = address
  end
  def get_address
    @address
  end 
end

# Mixin for phone
module EntryPhone
  def set_phone(phone)
    @phone = phone
  end
  def get_phone
    @phone
  end
end

 # This class holds the data fields for a single addressbook entry
 # !! Verify RDoc formating
 # !! Ruby class, method, varname naming per style guide?  
class AddressEntry
  include Comparable, EntryName, EntryAddress
  
  # Constructor. Or whatever it's called in Ruby
  # *  Parameter must be an array of 4 values
  
  # !! No constructor overloading? Workaround?
  def initialize(params)
    set_lname(params[0].lstrip.rstrip)
    set_fname(params[1].lstrip.rstrip)
    set_address(params[2].lstrip.rstrip)
  end
     
  def <=> other
    self.get_name_last_first <=> other.get_name_last_first
  end
  
  def to_s
    get_name_last_first + Formatting.equalTab(get_name_last_first.size)+get_address
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
      entry = AddressEntry.new(row)
      if @address_entries.keys.include? entry.get_name_last_first
        puts "ERROR: Entry for '"+entry.get_name+"' already exists in address book. Skipping."
      else
        @address_entries[entry.get_name_last_first] = entry
        @entry_count += 1
      end
    end
  end
  
  def get_total
    @entry_count
  end
  
  def get_all_entries
    @address_entries.values
  end
  
  def get_address_by_name(lname, fname)
    @address_entries[Formatting.formatName(@lname,@fname)].get_address
  end
end



 # This class holds the data fields for a single phonebook entry
class PhoneEntry
  include Comparable, EntryName, EntryPhone
  
  # Constructor. Or whatever it's called in Ruby
  # *  Parameter must be an array of 4 values
  
  # !! No constructor overloading? Workaround?
  def initialize(params)
    set_lname(params[0].lstrip.rstrip)
    set_fname(params[1].lstrip.rstrip)
    set_phone(params[3].lstrip.rstrip)
  end
     
  def <=> other
    self.get_phone <=> other.get_phone
  end
  
  def to_s
    get_phone + Formatting.equalTab(get_phone.size)+get_name_last_first
  end
end

# Container for phone book methods
class Phonebook
  def initialize()
    @phone_entries = Hash.new
    @name_entries = Hash.new
    @entry_count = 0
  end
  
  def load_csv(filename)
    raw = File.read(filename)
    csv = CSV.parse(raw, :headers => true)
    csv.each do |row|
      entry = PhoneEntry.new(row)
      if @phone_entries.keys.include? entry.get_phone
        puts "ERROR: Entry for '"+entry.get_phone+"' already exists in address book. Skipping."
      else
        @phone_entries[entry.get_phone] = entry
        @name_entries[entry.get_name_last_first] = entry
        @entry_count += 1
      end
    end
  end
  
  def get_total
    @entry_count
  end
  
  def get_all_entries
    @phone_entries.values
  end
  
  def get_phone_by_name(lname, fname)
    @name_entries[Formatting.formatName(@lname,@fname)].get_phone
  end
  
  def get_name_by_phone(phone)
    @phone_entries[phone].get_name_last_first
  end
  
end
  

# !! Class init method?
puts "### Loading Address data..."
abook = Addressbook.new
abook.load_csv('addresses.csv')

puts "Total: " + abook.get_total.to_s + " entries \n\n"
puts "Names: \n\n"

abook.get_all_entries.each do |entry|
  puts entry.to_s
end

puts "\nNames (sorted last/first): \n\n"
abook.get_all_entries.sort.each do |entry|
  puts entry.to_s
end




puts "\n\n\n\n### Loading Phone data..."
pbook = Phonebook.new
pbook.load_csv('addresses.csv')

puts "Total: " + pbook.get_total.to_s + " entries \n\n"
puts "Phone numbers: \n\n"

pbook.get_all_entries.each do |entry|
  puts entry.to_s
end

puts "\nPhone numbers (sorted): \n\n"
pbook.get_all_entries.sort.each do |entry|
  puts entry.to_s
end
