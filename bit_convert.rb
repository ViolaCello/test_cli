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
# arr = random_array(10000, 9999999)
# arr.each do |x| 
# puts decimal_to_binary_test(x)
# if x==false
#     puts "BAD!!!"
#     break
# end
# end

def decimal_to_binary_string(n)
    result = ""
    while n>0 do
        result = (n%2).to_s + result
        n /= 2
    end
    return result
end

def decimal_to_binary_array(n)
    result = Array.new(n)
    while n>0 do
        result.unshift(n%2)
        n /= 2
    end
    return result.join
end

def testing_if_works(n)
    arr = random_array(n, 999999)
    arr.each do |x| 
        a = decimal_to_binary_array(x)
        b = decimal_to_binary_string(x)
        if a != b 
            puts "BAD! x=#{x}, a=#{a}, b=#{b}"
            break
        else 
            puts "a=#{a.length}, b = #{b.length}"
        end
    end
end


def start_test(arr)
    arr.each do |num| 
        puts "string first"

    Benchmark.bm do |x| 
        x.report { decimal_to_binary_string(num) }
        x.report { decimal_to_binary_array(num) }
    end
    puts "array first"
    Benchmark.bm do |x| 
        x.report { decimal_to_binary_array(num) }
        x.report { decimal_to_binary_string(num) }
    end
end
end

# This proved that decimal_to_binary_string was A LOT faster.
# arr = random_array(10, 9999999)
# start_test(arr)

def decimal_to_binary_ruby(n)
    return n.to_s(2)
end

arr = random_array(10, 9999999)
def test_string_vs_ruby(arr)
    arr.each do |num| 
        Benchmark.bm do |x| 
            x.report { decimal_to_binary_ruby(num) }
            x.report { decimal_to_binary_string(num)}
        end
    end
end

test_string_vs_ruby(arr)