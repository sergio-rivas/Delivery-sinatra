class CustomerView
  def list_customers(repo)
    customers = repo.all
    customers.each do |customer|
      puts "#{customer.id} - #{customer.name} \n#{customer.address}"
    end
  end

  def ask_customer_name
    puts "What is the new customer's name?"
    puts "< "
    gets.chomp
  end

  def ask_customer_address
    puts "What is the new customer's address?"
    puts "< "
    gets.chomp
  end
end
