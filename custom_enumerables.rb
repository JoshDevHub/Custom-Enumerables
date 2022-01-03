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

  def my_inject(init = nil)
    memo = init || first
    if init.nil?
      my_each_with_index do |e, i|
        next if i.zero?

        memo = yield(memo, e)
      end
    else
      my_each { |e| memo = yield(memo, e) }
    end
    memo
  end

  def my_proc_map(my_proc = nil)
    return to_enum unless my_proc.respond_to?(:call) || block_given?

    collection = []
    if my_proc.respond_to?(:call)
      my_each { |e| collection << my_proc.call(e) }
    else
      my_each { |e| collection << yield(e) }
    end
    collection
  end
end

puts 'my_proc_map vs. map'

def my_multiply_els(array)
  array.my_inject(1) { |memo, number| memo * number }
end

def ruby_multiply_els(array)
  array.inject(1) do |memo, number|
    memo * number
  end
end

numbers = [2, 4, 5]
a_proc = proc { |e| e * 2 }
p numbers.map(&a_proc)
p numbers.my_map(&a_proc)
p numbers.my_proc_map(a_proc)

# Notes
# Inject with no args raises LocalJumpError
# Can take many different forms
# -> inject(init, sym)
# -> inject(sym)
# -> inject(init) { |memo, obj| block }
# -> inject { |memo, obj| block }

# TODO: inject with symbols/proc
# TODO: full test methods?
