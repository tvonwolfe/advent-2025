# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  class Grid
    Point = Data.define(:x, :y, :occupied) do
      def occupied? = !!occupied
      def to_s = "(#{x},#{y})"
    end

    attr_reader :rows, :length, :height

    def initialize(rows)
      @rows = rows
      @length = rows.first.length
      @height = rows.length
    end

    def accessible_points
      points = []
      rows.each do |row|
        row.each do |point|
          next unless point.occupied?

          is_accessible = adjacent_points(point).count(&:occupied?) < 4

          points << point if is_accessible
        end
      end

      points
    end

    def adjacent_points(point)
      x = point.x
      y = point.y

      [
        [x - 1, y - 1],
        [x - 1, y],
        [x - 1, y + 1],
        [x, y - 1],
        [x, y + 1],
        [x + 1, y - 1],
        [x + 1, y],
        [x + 1, y + 1]
      ].map do |other_x, other_y|
        next if other_x.negative? || other_y.negative?
        next if other_x > length - 1 || other_y > height - 1

        rows[other_y][other_x]
      end.compact
    end
  end

  def run
    rows = input.map.with_index do |line, y|
      line.chars.map.with_index do |char, x|
        Grid::Point.new(x:, y:, occupied: char == "@")
      end
    end

    grid = Grid.new(rows)

    grid.accessible_points.count
  end
end
