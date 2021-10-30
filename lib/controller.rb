require_relative 'view'
require_relative 'scrape_allrecipes_service'

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
    rating = @view.ask_for('rating')
    prep_time = @view.ask_for('prep_time')
    recipe = Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
    # add recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    # display the recipes
    display_recipes
    # ask the index
    index = @view.ask_for_index
    # mark
    @cookbook.mark_as_done(index)
  end

  def destroy
    # display the recipes
    display_recipes
    # ask the view to ask the user for an index
    index = @view.ask_for_index
    # delete the recipe from the cookbook using the index
    @cookbook.remove_recipe(index)
  end

  def import
    # ask the user for the ingredient
    ingredient = @view.ask_for('ingredient')
    # using the ingredient, search allrecipes for 5 recipes(scrape => should give us an array of recipe instances)
    recipes = ScrapeAllrecipesService.new(ingredient).call
    # display recipes for the user
    @view.display(recipes)
    # ask the user for the index of the recipe to import
    index = @view.ask_for_index
    # use the index on our array of recipes to get a recipe instance
    recipe = recipes[index]
    # add it to the cookbook
    @cookbook.add_recipe(recipe)
  end

  private

  def display_recipes
    # retrieve all the recipes from the cookbook
    recipes = @cookbook.all
    # call the view to display the recipes
    @view.display(recipes)
  end
end
