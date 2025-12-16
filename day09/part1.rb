# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  Point = Data.define(:x, :y)

  Pair = Data.define(:a, :b) do
    def area
      length = (a.x - b.x).abs + 1
      width = (a.y - b.y).abs + 1

      length * width
    end
  end

  def run
    biggest = 0
    input.each_with_index do |point, index|
      input[index..].each do |other_point|
        pair = Pair.new(point, other_point)
        next if pair.area <= biggest

        biggest = pair.area
      end
    end

    biggest
  end

  def input
    super.map do |line|
      Point.new(*line.split(",").map(&:to_i))
    end
  end
end
