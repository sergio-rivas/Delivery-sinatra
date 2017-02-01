class View
  def ask_for_new_recipe
    puts "What recipe would you like to add?"
    print "< "
    gets.chomp
  end

  def ask_for_description
    puts "What is a basic description of this recipe?"
    print "< "
    gets.chomp
  end

  def ask_for_cooking_time
    puts "How long does it take to cook this recipe?"
    print "< "
    gets.chomp
  end

  def show_all_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      x = recipe.done ? "X" : " "
      puts "[#{x}] #{index + 1} - #{recipe.name} (#{recipe.cooking_time} min) \n#{recipe.description}"
    end
  end

  def ask_recipe_index(recipes)
    puts "Which recipe?"
    show_all_recipes(recipes)
    print "< "
    gets.chomp.to_i - 1
  end

  def request_ingredient
    puts "What ingredient?"
    print "< "
    gets.chomp
  end

  def request_recipe_choice(recipes, cooking_times)
    puts "Which recipe would you like to add?"
    recipes.each_with_index { |element, i| puts "#{i + 1} - #{element.attribute('title')} (#{cooking_times[i]} min)" }
    print "< "
    gets.chomp.to_i - 1
  end
end
