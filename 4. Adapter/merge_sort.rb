#--------------------------------------------------------------------
# An external iterator for an array.
# Taken from [OLSEN] pp 128-129.
class ArrayIterator

  def initialize(array)
    @array = array
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end

#--------------------------------------------------------------------
# Adapts an Enumerator object soso that it behaves like an
# ArrayIterator.
class EnumeratorToArrayIteratorAdapter

  def initialize(enumerator)
    @enumerator = enumerator
  end

  def has_next?
    begin
      @enumerator.peek
      true
    rescue StopIteration
      false
    end
  end

  def item
    @enumerator.peek
  end

  def next_item
    if has_next?
      @enumerator.next
    else
      nil
    end
  end

end

#--------------------------------------------------------------------
# Using external iterators to implement merge sort.
# Taken from [OLSEN] p. 132.
def merge(array1, array2)
  merged = []

  iterator1 = EnumeratorToArrayIteratorAdapter.new(array1.to_enum)
  iterator2 = EnumeratorToArrayIteratorAdapter.new(array2.to_enum)

  while (iterator1.has_next? and iterator2.has_next?)
    if iterator1.item < iterator2.item
      merged << iterator1.next_item
    else
      merged << iterator2.next_item
    end
  end

  # Pick up the leftovers from array1
  while (iterator1.has_next?)
    merged << iterator1.next_item
  end

  # Pick up the leftovers from array2
  while (iterator2.has_next?)
    merged << iterator2.next_item
  end

  merged
end

a1 = [4, 5, 5, 6, 7, 8, 10, 20]
a2 = [1, 2, 3, 4, 5, 6, 8]
a3 = merge(a1, a2)
p a3
