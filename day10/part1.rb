# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  def num_presses(on_state, buttons)
    press_count = 1
    return press_count if buttons.include?(on_state)

    loop do
      press_count += 1
      result_states = buttons.permutation(press_count).map do |permutation|
        permutation.reduce(:^)
      end

      break press_count if result_states.include?(on_state)
    end
  end

  def run
    input.reduce(0) do |sum, (on_state, buttons)|
      sum + num_presses(on_state, buttons)
    end
  end

  def input
    super.map do |line|
      on_state_str = line.match(/\[(.*)\]/).to_a[1]
      buttons_indices = line.match(/](.*){/).to_a[1].split.map do |button_tuple_str|
        button_tuple_str[1..-2].split(",").map(&:to_i)
      end

      on_state = 0
      buttons = []
      on_state_str.chars.reverse.each_with_index do |char, index|
        on_state |= 1 << index if (char == "#")
      end

      buttons_indices.each do |button_indices|
        button = 0

        button_indices.each do |index|
          button |= 1 << on_state_str.length - index - 1
        end

        buttons << button
      end

      [on_state, buttons]
    end
  end
end
