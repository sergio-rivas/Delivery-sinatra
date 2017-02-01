require_relative 'app/controllers/meals_controller'
require_relative 'app/controllers/customers_controller'
require_relative 'app/controllers/orders_controller'


class Router
  def initialize(attributes = {})
    @meals_repo = attributes[:meals_repo]
    @meals_controller = MealsController.new(@meals_repo)
    @customers_repo = attributes[:customers_repo]
    @customers_controller = CustomersController.new(@customers_repo)
    @employees_repo = attributes[:employees_repo]
    @orders_repo = attributes[:orders_repo]
    @orders_controller = OrdersController.new(@meals_repo, @employees_repo, @customers_repo, @orders_repo)
    @running = true
  end

  def run
    @employee = session
    puts "Welcome to Delivery App!"
    while @running
      display_manager_tasks if @employee.manager?
      display_delivery_tasks if @employee.delivery_guy?
      action = gets.chomp.to_i
      print `clear`
      route_manager_action(action) if @employee.manager?
      route_delivery_action(action) if @employee.delivery_guy?
    end
  end

  private

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 7 then stop
    else puts "Please Make Your Choice."
    end
  end

  def route_delivery_action(action)
    case action
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 3 then stop
    else
      puts "Please Make Your Choice."
    end
  end

  def stop
    @running = false
  end

  def display_manager_tasks
    puts ""
    puts "What would you like to do?"
    puts "1 - List all meals"
    puts "2 - Create a new meal"
    puts "3 - List all customers"
    puts "4 - Create a new customer"
    puts "5 - Submit new order"
    puts "6 - View Undelivered Orders"
    puts "7 - Stop and exit the program"
  end

  def display_delivery_tasks
    puts ""
    puts "What would you like to do?"
    puts "1 - View my orders"
    puts "2 - Mark order as delivered"
    puts "3 - Stop and exit the program"
  end

  def session
    puts "username?"
    username = gets.chomp
    puts "password?"
    password = gets.chomp
    verify_session(username, password)
  end

  def verify_session(username, password)
    return session if @employees_repo.find_by_username(username).nil?
    employee = @employees_repo.find_by_username(username)
    unless employee.password == password
      puts "Wrong credentials! Try again, you fool!"
      return session
    end
    return employee
  end
end
