#!/usr/bin/env ruby
require 'benchmark'
# n = 5000000
# Benchmark.bm do |x|
#   x.report { for i in 1..n; a = "1"; end }
#   x.report { n.times do   ; a = "1"; end }
#   x.report { 1.upto(n) do ; a = "1"; end }
# end



class Node
    attr_accessor :value, :left, :right
    # @@all = []

    def initialize(value)
        @value = value
        @left = nil
        @right = nil
        # @@all << self
    end



end

class BinarySearchTree
    attr_accessor :root

    def initialize
        @root = nil
    end

    def insert(value)
        new_node = Node.new(value)
        if !root
            @root = new_node
            return self
        end
        current = @root
        while current do
            return nil if current.value == value
            if value > current.value
                if !current.right
                    current.right = new_node
                    break
                else 
                    current = current.right
                end
            else 
                if !current.left
                    current.left = new_node
                    break
                else 
                    current = current.left
                end
            end
        end
        return self
    end

    def find(value)
        return false if !@root
        current = @root
        while !!current do
            return true if current.value == value
            if value > current.value
                return false if !current.right
                current = current.right
            else 
                return false if !current.left
                current = current.left
            end
        end
    end

    def find_recursive(value, current = @root)
        return false if !current
        return true if current.value == value
        return find_recursive(value, current.right) if value > current.value
        return find_recursive(value, current.left) if value < current.value
    end

     def depth_first_search_in_order
        @result = []
        def travserse(node)
            travserse(node.left) if !!node.left
            @result.push(node.value)
            travserse(node.right) if !!node.right
        end
        travserse(@root)
        return @result
    end

end # end class


# def create_sorted
#   arr = Array.new(1000000)
#   i = 0
#   while i < 1000000
#     arr.push(i+5)
#     i += 1
#   end
#   return [arr, arr, arr] 
# end

def create_unsorted
  tree = BinarySearchTree.new 

  i = 0
  while i < 1000000 
    tree.insert(rand(99999999))
    i += 1
  end
  return tree 
end

def create_sort_array(root)
  arr = []
  arr = root.depth_first_search_in_order
  return arr
end

  
def binary_search_iterative(query, arr)
  while true do
    return false if arr.length<=1 && (arr[0]==nil || arr[0]!=query)
    if arr.length==2
        return true if arr[0]==query || arr[1]==query
        return false
    end
    midpoint = (arr.length/2).floor
    left = arr[0..midpoint-1]
    right = arr[midpoint+1..arr.length]
    return true if arr[midpoint]==query
    if arr[midpoint] > query
        arr = left
    else 
        arr = right
    end
  end
end

def start_test(n = 1)
  i = 0 
  while i < n 
  tree = create_unsorted
  arr = create_sort_array(tree)
  q = rand(9999999)
  Benchmark.bm do |x|
    x.report {  tree.find_recursive(q) }
  x.report {  tree.find(q) }
  x.report {  binary_search_iterative(q,arr) }
  x.report {  arr.include?(q) }
  
  

 
  end
i += 1
end
end

def show_av(n)
    test1 = []
    test2 = []
    test3 = []
    test4 = []

    i = 0
    while i < n do 
        x = start_test(1)
        test1.push(x[0].total)
        test2.push(x[1].total)
        test3.push(x[2].total)
        test4.push(x[3].total)
    end
    
    puts "find_recursive = #{test1.sum / n}"
    puts "tree.find = #{test2.sum / n}"
    puts "binary_search_iterative = #{test3.sum / n}"
    puts "Ruby.include? = #{test4.sum / n}"

end


