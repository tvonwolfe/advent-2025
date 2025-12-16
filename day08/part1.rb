# frozen_string_literal: true

require_relative "../runner"

class Part1 < Runner
  JunctionBox = Struct.new(:x, :y, :z) do
    def distance(other)
      x_diff = x - other.x
      y_diff = y - other.y
      z_diff = z - other.z

      Math.sqrt((x_diff**2) + (y_diff**2) + (z_diff**2))
    end

    attr_accessor :circuit
  end

  LineSegment = Data.define(:a, :b) do
    def distance = a.distance(b)
  end

  def run
    junction_boxes = input.map do |line|
      x, y, z = line.split(",").map(&:to_i)
      JunctionBox.new(x, y, z)
    end
    line_segments = []

    junction_boxes.each_with_index do |point, point_index|
      junction_boxes.each_with_index do |other_point, other_point_index|
        next if other_point_index <= point_index

        line_segments << LineSegment.new(point, other_point)
      end
    end

    line_segments = line_segments.sort_by(&:distance)
    circuits = []

    1000.times do |i|
      line_segment = line_segments[i]

      if (line_segment.a.circuit && line_segment.b.circuit)
        if line_segment.a.circuit != line_segment.b.circuit
          line_segment.b.circuit.each do |junction_box|
            junction_box.circuit = line_segment.a.circuit
            line_segment.a.circuit << junction_box
          end
        end
      elsif (line_segment.a.circuit)
        line_segment.b.circuit = line_segment.a.circuit
        line_segment.a.circuit << line_segment.b
      elsif (line_segment.b.circuit)
        line_segment.a.circuit = line_segment.b.circuit
        line_segment.b.circuit << line_segment.a
      else
        circuit = Set.new
        line_segment.a.circuit = circuit
        line_segment.b.circuit = circuit
        circuit << line_segment.a
        circuit << line_segment.b
        circuits << circuit
      end
    end

    circuits.map(&:size).sort.last(3).reduce(:*)
  end
end
