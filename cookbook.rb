require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes

  def initialize(csv_file_path = nil)
    @filepath = csv_file_path
    @recipes = []
    if csv_file_path
      CSV.foreach(csv_file_path) do |recipe|
        @recipes << Recipe.new(recipe[0], recipe[1], recipe[2], recipe[3], recipe[4])
      end
    end
  end

  def all
    @recipes
  end

  def mark_done(recipe_index)
    @recipes[recipe_index].done = 'yes'
    if @filepath
      csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
      CSV.open(@filepath, 'wb', csv_options) do |csv|
        @recipes.each do |recipe|
          csv << [recipe.name, recipe.description, recipe.prep_time,
                  recipe.difficulty, recipe.done]
        end
      end
    end
  end

  def save
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@filepath, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time,
                recipe.difficulty, recipe.done]
      end
    end
  end

  def add_recipe(recipe)
    # TODO
    if @filepath
      csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
      CSV.open(@filepath, 'a+', csv_options) do |csv|
        csv << [recipe.name, recipe.description, recipe.prep_time,
                recipe.difficulty, recipe.done]
      end
    end
    @recipes << recipe
  end

  def remove_recipe(recipe_index)
    # TODO
    @recipes.delete_at(recipe_index)
    if @filepath
      csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
      CSV.open(@filepath, 'wb', csv_options) do |csv|
        @recipes.each do |recipe|
          csv << [recipe.name, recipe.description, recipe.prep_time,
                  recipe.difficulty, recipe.done]
        end
      end
    end
  end
end
