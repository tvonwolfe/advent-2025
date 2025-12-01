class Runner
  def self.run(*)
    result = new(*).run
    return unless result

    puts "#{name} Result: #{result}"
  end

  # @param input [Array<String>]
  def initialize(input)
    @input = input
  end

  def run
    raise NoMethodError, "Must define #{__method__}!"
  end

  private

  attr_reader :input
end
