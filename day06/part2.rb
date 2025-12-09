# frozen_string_literal: true

require_relative "../runner"

class Part2 < Runner
  def run
    input.map.with_index do |problem, index|
      operands = (problem.first.length - 1).downto(0).map do |i|
        digits = problem.map { |row| row[i] }
        digits.join.to_i
      end

      operator = problem[-1].strip.to_sym
      operands.reduce(operator)
    end.sum
  end

  def input
    # split but looking at number of spaces between operators
    # 2x2 grid, iterate over each column from top to bottom
    # apply operator
    ranges = []
    current_start_index = 0

    super.last.chars.each_with_index do |char, index|
      next if index.zero?
      next (ranges << (current_start_index..index)) if index == super.last.length - 1

      if char != " "
        ranges << (current_start_index..(index - 2))
        current_start_index = index
      end
    end

    problems = []
    super.each do |line|
      ranges.each_with_index do |range, index|
        problems[index] ||= []
        problems[index] << line[range]
      end
    end

    problems
  end
end
