def solve_puzzle(hangman)
  hangman.guess(hangman.solution_diff.keys.reverse.join)
end
