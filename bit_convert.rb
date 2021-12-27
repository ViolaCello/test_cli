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

p random_array(25, 100)