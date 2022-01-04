# frozen_string_literal: true

require 'pry-byebug'

# My Enumerable methods
module Enumerable
  def my_each
    if block_given?
      length.times { |i| yield self[i] }
      self
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      length.times { |i| yield self[i], i }
      self
    else
      to_enum(:my_each_with_index)
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
      to_enum(:my_map)
    end
  end

  def my_inject(*args)
    case args
    in [Symbol] # rubocop: disable Lint/Syntax
      symbol = args[0]
    in [Object] # rubocop: disable Lint/Syntax
      init = args[0]
    in [a, Symbol] # rubocop: disable Lint/Syntax
      init = a
      symbol = args[1]
    end
    memo = init || first
    if block_given? || symbol
      my_each_with_index do |e, i|
        next if i.zero? && init.nil?

        memo = if block_given?
                 yield(memo, e)
               else
                 memo.send(symbol, e)
               end
      end
    memo
    end
  end

  def my_proc_map(my_proc = nil)
    return to_enum(:my_map) unless my_proc.respond_to?(:call) || block_given?

    collection = []
    if my_proc.respond_to?(:call)
      my_each { |e| collection << my_proc.call(e) }
    else
      my_each { |e| collection << yield(e) }
    end
    collection
  end
end # rubocop: disable Lint/Syntax
