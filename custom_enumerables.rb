# frozen_string_literal: true

require 'pry-byebug'

# My Enumerable methods
module Enumerable
  def my_each
    # binding.pry
    if block_given?
      length.times do |i|
        yield self[i]
      end
      self
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      length.times do |i|
        yield self[i], i
      end
      self
    else
      to_enum
    end
  end

  def my_select
    if block_given?
      results = []
      my_each { |e| results << e if yield(e) }
      results
    else
      to_enum
    end
  end
end

puts 'my_select vs. select'
numbers = [1, 2, 3, 4, 5]
p numbers.my_select { |e| e < 3 }
p numbers.select { |e| e < 3 }

# TODO: test current methods with strings and hashes
