class OrderView
  def list_undelivered(o_repo)
    message = ""
    o_repo.undelivered_orders.each do |order|
      puts "#{order.id} - #{order.customer.name} (#{order.meal.name}) Delivery Guy: #{order.employee.username})\n"
    end
    message
  end

  def ask_meal_id(m_repo)
    puts "Which meal would you like to add?\n"
    list_meals(m_repo)
    puts "< "
    gets.chomp
  end

  def ask_customer_id(c_repo)
    puts "Which customer would you like to send to?"
    list_customers(c_repo)
    puts "< "
    gets.chomp
  end

  def ask_employee_id(e_repo)
    puts "Which employee would you like to assign for delivery?"
    list_delivery_guys(e_repo)
    puts "< "
    gets.chomp
  end

  def list_meals(m_repo)
    m_repo.all.each do |meal|
      puts "#{meal.id} - #{meal.name} (#{meal.price} Euros)"
    end
  end

  def list_customers(c_repo)
    c_repo.all.each do |customer|
      puts "#{customer.id} - #{customer.name} \n#{customer.address}"
    end
  end

  def list_delivery_guys(e_repo)
    e_repo.all_delivery_guys.each do |employee|
      puts "#{employee.id} - #{employee.username}" if employee.delivery_guy?
    end
  end

  def mark_delivered
    puts "Which order would you like to mark complete?"
    puts "< "
    gets.chomp
  end
end
