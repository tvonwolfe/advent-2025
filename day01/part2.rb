# frozen_string_literal: true

require_relative "../runner"

class Part2 < Runner
  class Dial
    attr_reader :position, :zero_clicks

    MIN_POSITION = 0
    MAX_POSITION = 99
    NUM_POSITIONS = (MIN_POSITION..MAX_POSITION).size

    def initialize
      @position = 50
      @zero_clicks = 0
    end

    def turn_left(distance)
      return self if distance.zero?

      diff = position - distance
      end_position = diff % NUM_POSITIONS

      zero_clicks = (diff / NUM_POSITIONS).abs
      zero_clicks -= 1 if position.zero?
      zero_clicks += 1 if end_position.zero?

      self.position = end_position
      self.zero_clicks += zero_clicks

      self
    end

    def turn_right(distance)
      return self if distance.zero?

      diff = position + distance
      end_position = diff % NUM_POSITIONS

      zero_clicks = (diff / NUM_POSITIONS)

      self.position = end_position
      self.zero_clicks += zero_clicks

      self
    end

    private

    attr_writer :position, :zero_clicks
  end

  REGEX = /(L|R)(\d+)/.freeze

  def run
    dial = Dial.new

    input.each do |line|
      _, direction, distance = REGEX.match(line).to_a
      distance = Integer(distance)
      case direction
      when "L"
        dial.turn_left(distance)
      when "R"
        dial.turn_right(distance)
      end
    end

    dial.zero_clicks
  end
end
