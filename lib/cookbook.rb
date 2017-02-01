require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file)
    @csv = csv_file
    @recipes = []
    csv_to_recipes
  end

  def csv_to_recipes
    CSV.foreach(@csv) do |row|
      @recipes << Recipe.new(row[0], row[1].to_i, row[2])
    end
  end

  def recipes_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.cooking_time, recipe.description]
      end
    end
  end

  def add_recipe(recipe)
    @recipes << recipe
    recipes_to_csv
  end

  def remove_recipe(recipe_id)
    @recipes.delete_at(recipe_id)
    recipes_to_csv
  end

  def recipe_cooked(recipe_id)
    @recipes[recipe_id].tested
  end

  def all
    @recipes
  end

  def find(index)
    @recipes[index]
  end
end






