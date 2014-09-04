class CodeMaker
  attr_reader :code

  CODE_LENGTH = 4

  def initialize(code = nil)
    @code = code || generate_code
  end

  def correct?(guess)
    Score.new(code, guess).correct?
  end

  def score(guess)
    Score.new(code, guess).evaluate
  end

  private

  def generate_code
    (1..CODE_LENGTH).map { ['r', 'g', 'y', 'b'].sample }.join
  end

  class Score
    def initialize(code, guess)
      @code = code.chars
      @guess = guess.downcase.chars
    end

    def evaluate
      [correct_colors_and_locations_count, correct_colors_but_incorrect_locations_count]
    end

    def correct?
      guess == code
    end

    private

    attr_reader :code, :guess

    def correct_colors_and_locations_count
      exact_matches.count
    end

    def correct_colors_but_incorrect_locations_count
      return 0 if correct?

      remaining_code, remaining_guess = non_exact_matches

      remaining_guess.chars.count { |char| remaining_code.sub!(char, '') }
    end

    def non_exact_matches
      select_matches { |a, b| a !=b }.transpose.map(&:join)
    end

    def exact_matches
      select_matches { |a, b| a ==b }
    end

    def select_matches(&block)
      code.zip(guess).select &block
    end
  end
end