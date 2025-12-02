# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  class Dial
    attr_reader :position

    MIN_POSITION = 0
    MAX_POSITION = 99
    NUM_POSITIONS = (MIN_POSITION..MAX_POSITION).size

    def initialize
      @position = 50
    end

    def turn(direction, distance)
      arithmetic_method = case direction
                          when :left then :-
                          when :right then :+
                          else raise ArgumentError, "Can't turn #{direction}"
                          end

      result = position.public_send(arithmetic_method, distance)

      self.position = result % NUM_POSITIONS
    end

    private

    attr_writer :position
  end

  REGEX = /(L|R)(\d+)/

    def run
      dial = Dial.new
      zero_count = 0

      input.each do |line|
        _, direction, distance = REGEX.match(line).to_a
        distance = Integer(distance)
        direction = case direction
                    when "L"
                      :left
                    when "R"
                      :right
                    end

        dial.turn(direction, distance)
        zero_count +=1 if dial.position.zero?
      end

      zero_count
    end
end
