# frozen_string_literal: true

require 'pry-byebug'

# My Enumerable methods
module Enumerable
  def my_each
    if block_given?
      length.times { |i| yield self[i] }
      self
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      length.times { |i| yield self[i], i }
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

  def my_all?
    bool = true
    my_each { |e| yield(e) || bool = false } if block_given?
    bool
  end
end

puts 'my_select vs. select'
numbers = [1, 2, 3, 4, 5]
p numbers.my_all?
p numbers.all?

# TODO: test current methods with strings and hashes
