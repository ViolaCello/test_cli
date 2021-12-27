#!/usr/bin/env ruby
require 'benchmark'

def random_array(n, up_to)
    result = Array.new(n)
    while n>0 do
        result[n-1] = rand(up_to)
        n -= 1
    end
    return result
end

def decimal_to_binary_test(n)
    old_n = n 
    result = ""
    while n>0 do
        result = (n%2).to_s + result
        n /= 2
    end
    return [result==old_n.to_s(2)]
end

# This confirms that it works up to number 9999999
arr = random_array(10000, 9999999)
arr.each do |x| 
puts decimal_to_binary_test(x)
if x==false
    puts "BAD!!!"
    break
end
end