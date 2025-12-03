# frozen_string_literal: true

require_relative "../runner"

class Part2 < Runner
  def valid_id?(id_str)
    valid = true
    max = id_str.length / 2

    #substring lengths
    range = (1..max)

    range.each do |chunk_length|
      next unless (id_str.length % chunk_length).zero?

      first_chunk = id_str.slice(0, chunk_length)
      rest = id_str.slice(chunk_length, id_str.length)

      num_chunks = rest.length / chunk_length

      0.upto(num_chunks - 1) do |chunk_index|
        chunk_start = chunk_index * chunk_length
        chunk_end = chunk_start + (chunk_length - 1)
        current_chunk = rest[chunk_start..chunk_end]

        break if first_chunk != current_chunk

        valid = false if chunk_index == (num_chunks - 1)
      end
    end

    valid
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
