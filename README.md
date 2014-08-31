Mastermind

Goal:

To write a CodeBreaker that can solve a mastermind game.

You are given a CodeMaker that you can query for scoring of your guesses.

Rules:
1. You may not modify the CodeMaker source code.
2. You may not interrogate the CodeMaker's internal representation of the secret code.
3. You can ask the CodeMaker three questions:
- correct_guess?
- number_of_correct_colors
- number_of_correct_locations

Note that the number_of_correct_colors does not include the number_of_correct_locations.

Example final integration spec:

it 'should break the code' do
  code_maker = CodeMaker.new

  code = CodeBreaker.new(code_maker).solve
  code_maker.correct_guess?(code).should be_true
end
