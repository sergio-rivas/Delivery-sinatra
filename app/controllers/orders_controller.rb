require_relative "../repositories/orders_repository"
require_relative "../views/order_view"
require_relative "../models/order"
require 'csv'
class OrdersController
  def initialize(m_repo, e_repo, c_repo, o_repo)
    @m_repo = m_repo
    @e_repo = e_repo
    @c_repo = c_repo
    @o_repo = o_repo
    @view = OrderView.new
  end

  def list_undelivered_orders
    @view.list_undelivered(@o_repo)
  end

  def add
    meal_id = @view.ask_meal_id(@m_repo)
    customer_id = @view.ask_customer_id(@c_repo)
    employee_id = @view.ask_employee_id(@e_repo)
    hashy = {}
    hashy[:meal] = @m_repo.find(meal_id.to_i)
    hashy[:employee] = @e_repo.find(employee_id.to_i)
    hashy[:customer] = @c_repo.find(customer_id.to_i)
    @o_repo.add(Order.new(hashy))
  end

  def list_my_orders(employee)
    @o_repo.all.each do |order|
      puts "#{order.customer.name} - #{order.meal.name}" if order.employee == employee
    end
  end

  def mark_as_delivered(employee)
    @view.list_undelivered(@o_repo)
    order_id = @view.mark_delivered.to_i
    order = @o_repo.find(order_id)
    order.deliver!
    @o_repo.save_csv
  end
end
