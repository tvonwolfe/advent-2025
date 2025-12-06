# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  class Grid
    Point = Data.define(:x, :y, :occupied) do
      def occupied? = !!occupied
    end

    attr_reader :rows

    def initialize(rows)
      @rows = rows
    end

    def accessible_points

    end
  end

  def run
    rows = input.map.with_index do |line, y|
      line.chars.map.with_index do |char, x|
        Grid::Point.new(x:, y:, occupied: char == "@")
      end
    end

    grid = Grid.new(rows)

    grid.accessible_points.length
  end
end
