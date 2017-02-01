require_relative "../repositories/customers_repository"
require_relative "../views/customer_view"
require_relative "../models/customer"
require 'csv'
class CustomersController
  def initialize(repo)
    @repo = repo
    @view = CustomerView.new
  end

  def list
    @view.list_customers(@repo)
  end

  def add
    name = @view.ask_customer_name
    address = @view.ask_customer_address
    hashy = { name: name, address: address }
    @repo.add(Customer.new(hashy))
  end
end
