# Creates a generator that yields the powers of 2.
def pow2
  Enumerator.new do |yielder|
    n = 1
    loop do
      yielder << n
      n *= 2
    end
  end
end

# enum = pow2
# 1.upto 100 do
#   puts enum.next
# end

class TreeTraversal

  def preorder(root)
    Enumerator.new do |yielder|
      @yielder = yielder
      recursive_preorder(root)
    end
  end

  private

  def recursive_preorder(root)
    if not root.nil?
      @yielder << root[0]
      recursive_preorder(root[1])
      recursive_preorder(root[2])
    end
  end

end

tree =  ['A',
          ['B',
            ['D', nil, nil],
            nil],
          ['C',
            ['E', nil, nil],
            ['F',
              ['G', nil, nil],
              ['H', nil, nil]]]]

tt = TreeTraversal.new
enum = tt.preorder(tree)
p enum.to_a