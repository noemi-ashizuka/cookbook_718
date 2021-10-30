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

  def mark_as_done(index)
    recipe = @recipes[index]
    recipe.mark_unmark!
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |attributes|
      # we need to change the string from the csv file to the actual data we need (except for strings)
      # "true" == "true" => true
      # "false" == "true" => false
      attributes[:done] = attributes[:done] == "true"
      @recipes << Recipe.new(attributes)
    end
  end

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ['name', 'description', 'rating', 'prep_time', 'done']
      @recipes.each do |instance|
        csv << [instance.name, instance.description, instance.rating, instance.prep_time, instance.done?]
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
