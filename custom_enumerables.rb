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

  def my_count(argument = nil)
    return length unless block_given? || !argument.nil?

    total = 0
    my_each { |e| total += 1 if e == argument } unless argument.nil?
    total
  end
end

puts 'my_select vs. select'
numbers = [1, 2, 3, 4, nil]
p numbers.my_count('2')
p numbers.count { |e| e.nil? }

# TODO: get #my_count working with blocks // research blocks vs. args
# TODO: how to test for if arg is given?
# TODO: how to count nil argument
