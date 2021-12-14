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
end

puts 'my_each vs. each'
numbers = [1, 2, 3, 4, 5]
numbers.my_each_with_index { |e, i| puts "#{e} #{i}" }
numbers.each_with_index { |e, i| puts "#{e}" "#{i}" }
