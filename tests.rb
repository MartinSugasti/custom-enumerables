require_relative 'enumerable'
require 'pry-byebug'

arr = [1, 2, 3, 4]
arr_1 = [1, 'string', nil, 0.1]
hash = {:a=>1, :b=>2, :c=>3}

# my_each vs built-in each
puts "-------- #my_each vs #each --------"
arr.my_each { |item| puts item }
{'a' => 1, 'b' => 2}.my_each { |k, v| puts "#{k}, #{v}"}
puts ''

arr.each { |item| puts item }
{'a' => 1, 'b' => 2}.each { |k, v| puts "#{k}, #{v}"}
puts ''

# tests copied from https://github.com/thantko20/Custom-Enumerables/blob/master/compare_methods.rb

# my_each_with_index vs each_with_index
puts "-------- #my_each_with_index vs #each_with_index --------"
arr.my_each_with_index { |item, index| puts "item: #{item}, index: #{index}" }
puts ''

arr.each_with_index { |item, index| puts "item: #{item}, index: #{index}" }
puts ''

# my_select vs select
puts "-------- #my_select vs #select --------"
p arr.my_select { |item| item.even? }
p arr.select { |item| item.even? }
p hash.my_select { |k, v| v > 1 }
p hash.select { |k, v| v > 1 }
puts ''

puts "-------- #my_all? vs #all? --------"
p arr.my_all?(&:positive?)
p arr.all?(&:positive?)
puts ''

puts "-------- #my_any? vs #any? --------"
p arr.my_any?(&:odd?)
p arr.any?(&:odd?)
puts ''

puts "-------- #my_none? vs #none? --------"
p arr.my_none?(String)
p arr.none?(String)
puts ''

puts "-------- #my_count vs #count --------"
p arr.my_count(&:even?)
p arr.count(&:even?)
puts ''

puts "-------- #my_map vs #map --------"
a_proc = Proc.new { |el| el.to_s }
p arr.my_map(a_proc) # => ["1", "2", "3", "4"]
p arr.my_map(a_proc) { |i| i * 2 } # => ["1", "2", "3", "4"]
p arr.my_map { |i| i * 2 } # => [2, 4, 6, 8]
p arr.map { |i| i * 2 }
puts ''

puts "-------- #my_inject vs #inject --------"
p [2, 4, 5].inject(2) { |sum, n| sum * n }
p [2 ,4, 5].my_inject(2) { |sum, n| sum * n }
puts ''
