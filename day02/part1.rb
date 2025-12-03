# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  def valid_id?(id_str)
    return true unless (id_str.length % 2).zero?

    midpoint = id_str.length / 2

    first_half = id_str[0..(midpoint - 1)]
    second_half = id_str[midpoint..]

    first_half != second_half
  end

  def run
    input.reduce(0) do |agg, range|
      invalid_ids = []
      range.lazy.each do |id|
        invalid_ids << id unless valid_id?(id.to_s)
      end

      agg + invalid_ids.sum
    end
  end

  def input
    super.first.split(",").map(&:strip).map do |range_str|
      range_start, range_end = range_str.split("-").map(&:to_i)
      (range_start..range_end)
    end
  end
end
