require_relative "../repositories/meals_repository"
require_relative "../views/meal_view"
require_relative "../models/meal"
require 'csv'
class MealsController
  def initialize(repo)
    @repo = repo
    @view = MealView.new
  end

  def list
    @view.list_meals(@repo)
  end

  def add
    name = @view.ask_meal_name
    price = @view.ask_meal_price
    hashy = { name: name, price: price.to_i }
    @repo.add(Meal.new(hashy))
  end
end
