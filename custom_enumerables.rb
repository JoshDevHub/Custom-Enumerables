# frozen_string_literal: true

require 'pry-byebug'

# My Enumerable methods
module Enumerable
  def my_each
    # binding.pry
    if block_given?
      length = self.length
      length.times do |i|
        yield self[i]
      end
      self
    else
      to_enum
    end
  end
end

puts 'my_each vs. each'
numbers = [1, 2, 3, 4, 5]
numbers.my_each { |i| puts i }
numbers.each { |i| puts i }
