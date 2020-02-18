class Recipe
  attr_reader :name, :description, :prep_time, :difficulty
  attr_accessor :done

  def initialize(name, description, prep_time = 'unknown', difficulty = 'unknown', done = 'no')
    @name = name
    @description = description
    @prep_time = prep_time
    @difficulty = difficulty
    @done = done
  end
end
