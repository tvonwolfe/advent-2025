# frozen_string_literal: true

require_relative "../runner"

class Part2 < Runner
  def run
    break_index = input.find_index("")
    ranges = input[0..break_index - 1]

    ranges = ranges.map do |range_str|
      start_id, end_id = range_str.split("-").map(&:to_i)
      (start_id..end_id)
    end

    ranges = ranges.sort_by(&:begin)

    result_ranges = []

    ranges.each do |range|
      next result_ranges << range if result_ranges.empty?

      result_ranges.each_with_index do |other_range, index|
        # an existing range covers the current range
        if other_range.cover?(range)
          break
        end

        # this range covers an existing range. replace it
        if range.cover?(other_range)
          result_ranges[index] = range
          break
        end

        min_range = [range, other_range].min_by(&:begin)
        max_range = [range, other_range].max_by(&:end)

        # overlap. create new range and replace the one at this index.
        if min_range.end >= max_range.begin
          new_range = min_range.begin..max_range.end
          result_ranges[index] = new_range
          break
        end

        if index == result_ranges.length - 1
          result_ranges << range 
        end
      end
    end

    result_ranges.sum(&:size)
  end
end
