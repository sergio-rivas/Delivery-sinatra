require_relative "../models/employee"
require 'csv'
class EmployeesRepository
  attr_writer :employees

  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    load_csv
  end

  def load_csv
    @employees = []
    if File.exist?(@csv_file)
      csv_options = { headers: :first_row, header_converters: :symbol }
      CSV.foreach(@csv_file, csv_options) do |row|
        row[:id] = row[:id].to_i
        @employees << Employee.new(row)
      end
    end
  end

  def all_delivery_guys
    delivery_guys = []
    @employees.each do |employee|
      delivery_guys << employee if employee.delivery_guy?
    end
    return delivery_guys
  end

  def find(index)
    found = nil
    @employees.each { |employee| found = employee if index == employee.id }
    return found
  end

  def find_by_username(username)
    found = nil
    @employees.each { |employee| found = employee if employee.username == username }
    return found
  end
end
