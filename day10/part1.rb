# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  class Machine
    attr_reader :lights, :on_state, :buttons, :num_button_presses

    def initialize(on_state, buttons)
      @lights = Array.new(on_state.length, false)
      @on_state = on_state
      @buttons = buttons
      @num_button_presses = 0
    end

    def press_button(button_index)
      if button_index.negative? || button_index > buttons.length - 1
        raise ArgumentError, "Invalid button index: #{button_index}"
      end

      buttons[button_index].each { |i| lights[i] = !lights[i] }
      self.num_button_presses += 1
    end

    def on? = lights == on_state

    private

    attr_writer :num_button_presses
  end

  def run
    min_presses = input.map do |machine|

      permutations = [machine]
      next_permutations = []

      initialized_machine = loop do
        permutations.each do |permutation|
          machine.buttons.size.times do |i|
            next_permutation = permutation.clone
            next_permutation.press_button(i)


            next_permutations << next_permutation
          end

          permutations = next_permutations
          next_permutations = []

        end

        done = permutations.find(&:on?)
        break done unless done.nil?
      end

      initialized_machine.num_button_presses
    end

    min_presses.sum
  end

  def input
    super.map do |line|
      on_state = line.match(/\[(.*)\]/).to_a[1]
      buttons = line.match(/](.*){/).to_a[1].split.map do |button_tuple_str|
        button_tuple_str[1..-2].split(",").map(&:to_i)
      end

      Machine.new(on_state, buttons)
    end
  end
end
