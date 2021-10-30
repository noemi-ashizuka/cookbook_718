class View
  def display(recipes)
    if recipes.empty?
      puts 'No recipes yet! 😢'
    else
      recipes.each_with_index do |recipe, index|
        x_mark = recipe.done? ? "X" : " "
        puts "#{index + 1}) |[#{x_mark}]| #{recipe.name} - #{recipe.description} (#{recipe.rating}/ 5) - prep time: #{recipe.prep_time}"
      end
    end
  end

  def ask_for(thing)
    puts "What's the #{thing}?"
    print "> "
    gets.chomp
  end

  def ask_for_index
    puts "What's the number?"
    print "> "
    gets.chomp.to_i - 1
  end
end
