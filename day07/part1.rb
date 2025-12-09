# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  SPLITTER = "^"
  TACHYON = "|"

  def run
    input.first.gsub!("S", TACHYON)
    result = []
    num_splits = 0

    input.each_with_index do |current_line, index|
      next result << current_line if index.zero?

      previous_line = result[index - 1]
      result_line = current_line.clone

      previous_line.chars.each_with_index do |char_above, char_index|
        next unless char_above == TACHYON

        if current_line[char_index] == SPLITTER
          result_line[char_index - 1] = TACHYON
          result_line[char_index] = SPLITTER
          result_line[char_index + 1] = TACHYON
          num_splits += 1
        else
          result_line[char_index] = TACHYON
        end
      end

      result << result_line
    end

    num_splits
  end
end
