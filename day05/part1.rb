# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  def run
    break_index = input.find_index("")
    ranges = input[0..break_index - 1]
    ingredient_ids = input[(break_index+1)..].map(&:to_i)

    ranges = ranges.map do |range_str|
      start_id, end_id = range_str.split("-")
      (start_id.to_i..end_id.to_i)
    end

    fresh_available_ingredients = []
    ingredient_ids.each do |id|
      fresh_available_ingredients << id if ranges.any? do |range|
        range.include? id
      end
    end

    fresh_available_ingredients.count
  end
end
