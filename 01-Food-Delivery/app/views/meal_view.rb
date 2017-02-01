class MealView
  def list_meals(repo)
    meals = repo.all
    meals.each do |meal|
      puts "#{meal.name} (#{meal.price} Euros)"
    end
  end

  def ask_meal_name
    puts "What is the name of the meal you would like to add?"
    puts "< "
    gets.chomp
  end

  def ask_meal_price
    puts "How much does the meal cost?"
    puts "< "
    gets.chomp
  end
end
