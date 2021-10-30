require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # ask the view to ask user for recipe name and store it
    name = @view.ask_for('name')
    # ask the view to ask the user for recipe description and store it
    description = @view.ask_for('description')
    # create a recipe instance and store it
    recipe = Recipe.new(name, description)
    # add recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # display the recipes
    display_recipes
    # ask the view to ask the user for an index
    index = @view.ask_for_index
    # delete the recipe from the cookbook using the index
    @cookbook.remove_recipe(index)
  end

  private

  def display_recipes
    # retrieve all the recipes from the cookbook
    recipes = @cookbook.all
    # call the view to display the recipes
    @view.display(recipes)
  end
end
