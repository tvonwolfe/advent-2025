# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  def biggest_joltage(bank)
    largest = 0
    second = 1
    i = second

    while (i < bank.length)
      if i < bank.length - 1 && bank[i] > bank[largest]
        largest = i
        second = i + 1
        i = second
        next
      elsif bank[i] > bank[second]
        second = i
      end

      i += 1
    end

    "#{bank[largest]}#{bank[second]}".to_i
  end

  def run
    input.reduce(0) do |agg, bank|
      result = biggest_joltage(bank)
      agg + result
    end
  end
end
