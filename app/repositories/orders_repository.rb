require_relative "../models/order"
require 'csv'
class OrdersRepository
  attr_accessor :next_id
  attr_writer :orders

  def initialize(csv_file, m_repo, e_repo, c_repo)
    @csv_file = csv_file
    @meals = m_repo
    @orders = []
    @customers_repository = c_repo
    @employees_repository = e_repo
    @meals_repository = m_repo
    load_csv if File.exist?(@csv_file)
  end

  def load_csv
    @orders = []
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      hashy = { id: row[:id].to_i, delivered: row[:delivered] == 'true' }
      hashy[:meal] = @meals_repository.find(row[:meal_id].to_i)
      hashy[:employee] = @employees_repository.find(row[:employee_id].to_i)
      hashy[:customer] = @customers_repository.find(row[:customer_id].to_i)
      @orders << Order.new(hashy)
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_csv
    csv_options = { headers: ["id", "delivered", "meal_id", "employee_id", "customer_id"], write_headers: true }
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end

  def add(order)
    @next_id = 1 if @next_id.nil?
    order.id =  @next_id.to_i
    @next_id += 1
    @orders << order
    save_csv
  end

  def undelivered_orders
    undelivered = []
    @orders.each { |order| undelivered << order unless order.delivered? }
    return undelivered
  end

  def all
    @orders
  end

  def find(index)
    found = nil
    @orders.each { |order| found = order if index == order.id }
    return found
  end
end
