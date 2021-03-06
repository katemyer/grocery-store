require 'csv'
require 'awesome_print'

class Customer

  attr_accessor :id, :email, :address
  
  def initialize (id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all() #public method
    customer_record = CSV.read(__dir__ + "/../data/customers.csv")
    all_customers = []
    #0              1                      2            3         4   5
    #1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105
    customer_record.each do |record|
      id = record[0].to_i
      email = record[1].to_s
      address = {
        :street => record[2],
        :city => record[3],
        :state => record[4],
        :zip => record[5]
      }
      temp_customer = Customer.new(id, email, address)
      all_customers.push(temp_customer)
    end
    return all_customers
  end

#   self.find(id) - returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
# Customer.find should not parse the CSV file itself. Instead it should invoke Customer.all and search through the results for a customer with a matching ID.
  # Finds a Customer object based on id
  # Inputs:
  #   id (int) - this is a customer id
  # returns actual Customer object
  def self.find(id) #public method
    customers = self.all
    customers.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end

#******WAVE 3 *********************************************
# Create a method called save
# Creates a NEW csv file and adds a customer's details
# Inputs
  # filename (string) - this filename is what the file it will create
  # new_customer (Customer object) - a customer to be added to csv file
# return true all conditions

  def self.save(filename, aCustomer)
    # create a new csv file based on filename: https://stackoverflow.com/questions/12718872/how-do-i-create-a-new-csv-file-in-ruby
    CSV.open(filename, "wb") do |csv|
        # write customer information into the file
              #id,        email,                   street,      city,  state,  zip
              #1, leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105
      csv << [aCustomer.id, aCustomer.email, aCustomer.address[:street], aCustomer.address[:city], aCustomer.address[:state], aCustomer.address[:zip]]
    end
  
    return true
  end

end 

# {street: "123 Main", city: "Seattle", state: "WA", zip: "98101"}

# test_customer = Customer.new(1,"leonard.rogahn@hagenes.org",{street: "71596 Eden Route", city: "Connellymouth", state: "LA", zip: "98872"})
# puts test_customer
# puts test_customer.id
# puts test_customer.email
# puts test_customer.address
# puts Customer.all #self.all is public, so to call it, use the actual class name
# puts Customer.find(34).id

#Calling save method
# wave3_tempcustomer = Customer.new(100, "charlie@puppy.com",{street:"19201 ok street", city: "renton", state: "wa", zip: "21455"})
# puts Customer.save("new_customer.csv",wave3_tempcustomer)