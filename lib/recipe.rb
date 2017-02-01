class Recipe
  attr_reader :name, :description, :cooking_time, :done
  def initialize(name, cooking_time, description)
    @name = name
    @description = description
    @ingredients = []
    @cooking_time = cooking_time
    @done = false
  end

  def list_ingredients
    @ingredients
  end

  def add_ingredient(ingredient)
    @ingredients << ingredient
  end

  def remove_ingredient(ingredient_index)
    @ingredients.delete_at(ingredient_index)
  end

  def tested
    @done = true
  end
end
