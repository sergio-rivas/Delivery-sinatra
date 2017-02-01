require_relative "../models/meal"
require 'csv'
class MealsRepository
  attr_accessor :next_id
  attr_writer :meals

  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    load_csv
  end

  def load_csv
    @meals = []
    if File.exist?(@csv_file)
      csv_options = { headers: :first_row, header_converters: :symbol }
      CSV.foreach(@csv_file, csv_options) do |row|
        row[:id] = row[:id].to_i
        row[:price] = row[:price].to_i
        @meals << Meal.new(row)
      end
      @next_id = @meals.last.id + 1 unless @meals.empty?
    end
  end

  def save_csv
    csv_options = { headers: ['id', 'name', 'price'], write_headers: true }
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def add(meal)
    @next_id = 1 if @next_id.nil?
    meal.id =  @next_id.to_i
    @next_id += 1
    @meals << meal
    save_csv
  end

  def all
    @meals
  end

  def find(meal_id)
    found = nil
    @meals.each { |meal| found = meal if meal_id == meal.id }
    return found
  end
end
