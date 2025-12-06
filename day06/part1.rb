# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  def run
    input.map do |problem|
      operands = problem[0..-2].map(&:to_i)
      operator = problem[-1].to_sym
      operands.reduce(operator)
    end.sum
  end

  def input
    super.map!(&:split)

    0.upto(super.first.length-1).map do |i|
      super.map { |line| line[i] }
    end
  end
end
