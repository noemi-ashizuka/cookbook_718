class View
  def display(recipes)
    if recipes.empty?
      puts 'No recipes yet! 😢'
    else
      recipes.each_with_index do |recipe, index|
        puts "#{index + 1}) #{recipe.name} - #{recipe.description}"
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
