# frozen_string_literal: true

require_relative "../runner"

class Part2 < Runner
  def biggest_joltage(bank)
    accumulator = []

    i = 0
    while (accumulator.size < 12)
      end_possible_range = bank.size - (12 - (accumulator.size)) + 1
      largest = i

      while (i < end_possible_range)
        if bank[i] > bank[largest]
          largest = i
        end

        i += 1
      end

      accumulator << bank[largest]
      i = largest + 1
    end

    accumulator.join.to_i
  end

  def run
    input.reduce(0) do |agg, bank|
      result = biggest_joltage(bank)
      agg + result
    end
  end
end
