Mastermind

Goal:

To write a CodeBreaker that can solve a mastermind game.

You are given a CodeMaker that you can query for scoring of your guesses.

Rules:

1. You can ask the CodeMaker two questions:
  - correct?(guess)
  - score(guess) which returns a tuple representing:
    - correct_colors_and_locations_count
    - correct_colors_but_incorrect_locations_count

2. You may not modify the CodeMaker source code.

3. You may not peek at the CodeMaker's secret code.

4. For testing, you may tell the CodeMaker what secret code to use.

Note that the correct_colors_but_incorrect_locations_count does not include the correct_colors_and_locations_count.

Example final integration spec:

```
it 'breaks the code' do
  code_maker = CodeMaker.new

  code = CodeBreaker.new(code_maker).solve

  code_maker.correct?(code).should be_true
end
```
