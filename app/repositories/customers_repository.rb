require_relative "../models/customer"
require 'csv'
class CustomersRepository
  attr_accessor :next_id
  attr_writer :customers

  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    load_csv
  end

  def load_csv
    @customers = []
    if File.exist?(@csv_file)
      csv_options = { headers: :first_row, header_converters: :symbol }
      CSV.foreach(@csv_file, csv_options) do |row|
        row[:id] = row[:id].to_i
        row[:price] = row[:price].to_i
        @customers << Customer.new(row)
      end
      @next_id = @customers.last.id + 1 unless @customers.empty?
    end
  end

  def save_csv
    csv_options = { headers: ['id', 'name', 'address'], write_headers: true }
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def add(customer)
    @next_id = 1 if @next_id.nil?
    customer.id = @next_id.to_i
    @next_id += 1
    @customers << customer
    save_csv
  end

  def all
    @customers
  end

  def find(index)
    found = nil
    @customers.each { |customer| found = customer if index == customer.id }
    return found
  end
end
