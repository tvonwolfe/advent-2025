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

    result_ranges = []

    ranges.each do |range|
      next result_ranges << range if result_ranges.empty?

      result_ranges.each_with_index do |other_range, index|
        puts "range: #{range}, other range: #{other_range}"
        min_range = [range, other_range].min_by(&:begin)
        max_range = [range, other_range].max_by(&:end)

        # an existing range covers the current range
        next if (other_range == min_range) && (other_range == max_range)

        # this range covers an existing range. replace it
        break result_ranges[index] = range if range == min_range && range == max_range

        # overlap. create new range and replace the one at this index.
        if min_range.end > max_range.begin
          new_range = min_range.begin..max_range.end
          result_ranges[index] = new_range
          break
        end

        # no overlap.
        break result_ranges << range
      end
    end

    puts "#{result_ranges}"
    result_ranges.sum(&:size)
  end
end
