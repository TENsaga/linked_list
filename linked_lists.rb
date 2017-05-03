require 'pry'

# LinkedList data structure containing linked objects
# Links are established through Node objects and Node.next_node
class LinkedList
  attr_accessor :size, :head, :tail
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    node = Node.new(value)
    @head.nil? ? @head = node : @tail.next_node = node
    @tail = node
    @size += 1
  end

  def prepend(value)
    node = Node.new(value, @head)
    @head = node
    @size += 1
  end

  def at(index)
    return @head if index.zero?
    at(index - 1).next_node
  end

  def pop
    size.zero? ? return : @size -= 1
    if size.zero?
      @head, @tail = *nil
    else
      @tail = at(@size - 1)
      @tail.next_node = nil
    end
  end

  def contains?(value)
    (0..@size - 1).select { |i| at(i).value == value }.any?
  end

  def find(value)
    (0..@size - 1).find { |i| i if at(i).value == value }
  end

  def to_s
    (0..@size - 1).each { |i| print " ( #{at(i).value} ) ->" }
    print " nil\n"
  end

  def insert_at(index, value)
    return prepend(value) if index.zero?
    at(index - 1).next_node = Node.new(value, at(index))
    @size += 1
  end

  def remove_at(index)
    # pop() if index is last in chain, includes size == 1 to reset head/tail
    return pop if index == @size - 1

    if index.zero?
      @head = at(index + 1)
    else
      at(index - 1).next_node = at(index).next_node
    end
    @size -= 1
  end
end

class Node
  attr_accessor :value, :next_node
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
