class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false # boolean
  end

  def done?
    @done
  end

  def mark_unmark!
    @done = !@done
  end

  # def name
  #   @name
  # end
end

# pizza = Recipe.new({ name: "pizza" })
# p pizza
# cake = Recipe.new(name: "cake", description: "Sweet")
# p cake
