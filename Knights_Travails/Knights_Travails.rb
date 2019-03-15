require_relative "../Polytree_Node/lib/00_tree_node.rb"

class KnightPathFinder 

  attr_reader :position

  def initialize(position) 
    @position = position 
    @root_node = PolyTreeNode.new(position)
    @considered_positions =[]
  end 

  def self.valid_moves(pos)
    x, y = pos
    signs = [-1, 1] 
    moves = []
    valid_pos = (0..7).to_a 
    (1..2).each do |idx1|
      idx2 = 3 - idx1
      signs.each do |sign1|
        signs.each do |sign2|
          xpos = x + idx1*sign1
          ypos = y + idx2*sign2
          moves << [xpos,ypos] if valid_pos.include?(xpos) && valid_pos.include?(ypos)
        end
      end
    end 
    return moves 
  end 

  def new_move_positions(pos)
    @considered_positions << pos
    new_moves = []
    KnightPathFinder.valid_moves(pos).each do |move|
      new_moves << move if !@considered_positions.include?(move)
    end
    new_moves
  end

  def build_move_tree(target_position)
    queue = []
    queue.push(position)
    parent_node = nil  

    until queue.empty?
      current_position = queue.shift
      current_node = PolyTreeNode.new(current_position)
      current_node.parent = parent_node 
      return current_node.lineage if current_position == target_position
      new_moves = new_move_positions(current_position)
      new_moves.each {|move| queue << move}
      parent_node = current_node
    end 
      
  end




end 