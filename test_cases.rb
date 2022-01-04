# frozen_string_literal: true

require_relative 'custom_enumerables'
numbers = [1, 2, 3, 4, 5]

puts 'my_each vs. each'
numbers.my_each { |item| puts item }
numbers.each { |item| puts item }

puts 'my_each_with_index vs. each_with_index'
numbers.my_each_with_index { |item, index| puts "#{item} & #{index}" }
numbers.each_with_index { |item, index| puts "#{item} & #{index}" }

puts 'my_select vs. select'
p numbers.my_select(&:even?)
p numbers.select(&:even?)

puts 'my_all vs. all'
p(numbers.my_all? { |number| number.is_a? Integer })
p(numbers.all? { |number| number.is_a? Integer })

puts 'my_any vs. any'
p numbers.my_any?(&:even?)
p numbers.any?(&:even?)

puts 'my_none vs none'
p numbers.my_none?(&:zero?)
p numbers.none?(&:zero?)

puts 'my_count vs. count'
p numbers.my_count(1)
p numbers.count(1)

puts 'my_map vs. map'
p(numbers.my_map { |number| number * 2 })
p(numbers.map { |number| number * 2 })

puts 'my_inject vs. inject'
p numbers.my_inject(:+)
p numbers.inject(:+)

puts 'my_proc_map'
my_proc = proc { |e| e * 2 }
p numbers.my_proc_map(my_proc)
