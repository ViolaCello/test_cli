#!/usr/bin/env ruby

require 'benchmark'
# n = 5000000
# Benchmark.bm do |x|
#   x.report { for i in 1..n; a = "1"; end }
#   x.report { n.times do   ; a = "1"; end }
#   x.report { 1.upto(n) do ; a = "1"; end }
# end

class Node 
  attr_accessor :val, :next

  def initialize(val)
    @val = val 
    @next = nil 
  end

end

class SLL 
  attr_accessor :head 

  def initialize
    @head = nil 
    @tail
  end

  def push(val)
    node = Node.new(val)
    if !@head 
      @head = node 
      @tail = node
    else 
      temp = @tail 
      temp.next = node 
      @tail = node 
    end
  end

  def find(val)
    return false if !@head
    current = @head
    while current do 
      return true if current.val == val 
      return false if current == @tail 
      current = current.next 
    end
  return false
  end

  def insert(index, key)
    node = Node.new(key)
    if !@head 
      @head = node 
      @tail = node 
      return 
    end
    if index == 0 
      temp = @head
      @head = node 
      node.next = temp
      return
    end
    i = 1
    current = head 
    while i < index && current != @tail 
      current = current.next 
      i += 1
    end
    if current == @tail 
      self.push(key)
    else current.next
      temp = current.next
      current.next = node 
      node.next = temp
    end
  end

  def remove_at(index)
    return if !@head
    if index == 0
      if !@head.next
        @head = nil 
        @tail = nil 
        return
      else 
        @head = @head.next
        return
      end
    end
    current = @head
    i = 0
    while i < index && current != @tail
      prev = current
      current = current.next
      i += 1
    end
    if current == @tail
      @tail = prev
      return
    end
    return false if i < index 
    prev.next = current.next
    return
  end

  def print2arr
    return [] if !@head
    arr = []
    current = @head
    while current do 
      arr.push(current.val)
      return arr if current == @tail
      current = current.next
    end
  end

end # end class

# arr = Array.new(1000000)
# i = 0
# while i < 1000000
#   arr[i] = i
#   i += 1
# end

def testing1
  list = SLL.new 
  arr = []
 
  Benchmark.bmbm do |x|

    x.report {
    i = 0 
    while i < 1000000
      arr.push(i)
      i += 1
    end
  }

  x.report {
    
    i = 0
    while i < 1000000
    list.push(i)
    i += 1
    end
    }

end

end



def testing2(n)
  list = SLL.new 
  arr = []
  i = 0
  while i < n 
    r = rand(99999)
    list.push(r)
    arr.push(r)
    i += 1
  end
  
 q = rand(99999)
   Benchmark.bmbm do |x|

    x.report {
    list.find(q)
  }

  x.report {
   arr.include?(q)
  }

  end
end

def test_insert(n)
   list = SLL.new 
  arr = []
  i = 0
  while i < n 
    r = rand(9999)
    list.push(r)
    arr.push(r)
    i += 1
  end
  mid = n/2

  Benchmark.bmbm do |x|

    x.report {
    list.insert(mid, 666.99999)
  }

  x.report {
   arr.insert(mid, 666.99999)
  }

  end
   # puts list.inspect
  v = list.print2arr
  puts v == arr
end

def test_remove(n)
     list = SLL.new 
  arr = []
  i = 0
  while i < n 
    r = rand(99999)
    list.push(r)
    arr.push(r)
    i += 1
  end
  mid = n/2

  Benchmark.bmbm do |x|

 x.report {
    list.remove_at(mid)
  }

    x.report {
   arr.delete_at(mid)
  }


   

  

  end

  v = list.print2arr
  puts v == arr
end

def run_test(n, t)
  test1 = []
  test2 = []

  i = 0
  while i < t 
  x = testing2(n)
  test1.push(x[0].total * 100 )
  test2.push(x[1].total * 100 )
  i += 1
  end

  puts test1.sum(0.0) / (t-1)
  puts test2.sum(0.0) / (t-1)
end

 run_test(100000,100)

# test_insert(10)
# test_remove(1000000)