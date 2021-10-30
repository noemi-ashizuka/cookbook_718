require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      @recipes.each do |instance|
        csv << [instance.name, instance.description]
      end
    end
  end
end

# cookbook = Cookbook.new('recipes.csv')
# p cookbook

# onigiri = Recipe.new('onigiri', 'rice and seaweed')
# cookbook.add_recipe(onigiri)

# p cookbook.all

# cookbook.remove_recipe(0)
# p cookbook.all
