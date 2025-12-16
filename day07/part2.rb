# frozen_string_literal: true

require_relative "../runner"

class Part2 < Runner
  SPLITTER = "^"
  START = "S"

  def run
    width = input.first.length
    lasers = Array.new(width, 0)
    lasers[input.first.index(START)] = 1


    input[1..].each do |line|
      buffer = Array.new(width, 0)

      line.chars.each_with_index do |char, index|
        next if lasers[index].zero?

        next buffer[index] += lasers[index] unless char == SPLITTER

       # splitter
        if index.positive?
          buffer[index - 1] += lasers[index]
        end

        if index < width - 1
          buffer[index + 1] += lasers[index]
        end
      end

      lasers = buffer
    end

    lasers.sum
  end
end
