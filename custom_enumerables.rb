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

  def my_any?
    bool = true
    bool = false if block_given? && my_all? { |e| !yield(e) }
    bool
  end

  def my_none?
    bool = false
    bool = true if block_given? && !my_any? { |e| yield(e) }
    bool
  end

  def my_count(argument = omitted = true)
    total = 0
    if !omitted
      my_each { |e| total += 1 if e == argument }
    elsif block_given?
      my_each { |e| total += 1 if yield(e) }
    else
      return length
    end
    total
  end

  def my_map
    if block_given?
      result_container = []
      my_each do |e|
        result_element = yield(e)
        result_container << result_element
      end
      result_container
    else
      to_enum
    end
  end
end

puts 'my_select vs. select'
numbers = [1, 2, 4, 4, 5]
p numbers.my_map { |e| e**2 }
p numbers.map { |e| e** 2 }
