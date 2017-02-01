require_relative "recipe"
require_relative "cookbook"
require_relative "view"
require_relative "browser"
# require "nokogiri"
require "open-uri"

class Controller
  def initialize(cookbook)
    @view = View.new
    @cookbook = cookbook
    @browser = Browser.new
  end

  def create
    new_recipe = @view.ask_for_new_recipe
    new_cooking_time = @view.ask_for_cooking_time
    new_description = @view.ask_for_description
    recipe = Recipe.new(new_recipe, new_cooking_time, new_description)
    @cookbook.add_recipe(recipe)
    "Recipe Added!"
  end

  def list
    recipes = @cookbook.all
    @view.show_all_recipes(recipes)
  end

  def destroy
    recipes = @cookbook.all
    recipe_index = @view.ask_recipe_index(recipes)
    @cookbook.remove_recipe(recipe_index)
    puts "Recipe Removed!"
  end

  def tested
    recipes = @cookbook.all
    recipe_index = @view.ask_recipe_index(recipes)
    @cookbook.recipe_cooked(recipe_index)
    "Done!"
  end

  def import
    # request ingredient
    ingredient = @view.request_ingredient
    # search for ingredient
    html_docs = @browser.html_doc_set(ingredient)
    recipes = @browser.fetch_recipes(html_docs)
    descriptions = @browser.fetch_descriptions(html_docs)
    cooking_times = @browser.calculate_cookingtimes(html_docs)
    # request index choice
    i = @view.request_recipe_choice(recipes, cooking_times)
    # importing message/import action.
    puts "Importing..."
    new_recipe = Recipe.new(recipes[i].attribute('title'), cooking_times[i], descriptions[i].text)
    @cookbook.add_recipe(new_recipe)
    "Recipes added!"
  end
end
