
require "byebug"

class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def lineage
    ancestor = parent   
    lineage = []
    while ancestor != nil
      lineage << ancestor.value 
      ancestor = ancestor.parent 
    end 
    lineage
  end 

  def parent=(new_parent)
    if parent != new_parent
      if !@parent.nil?
        @parent.children.reject! {|child| child == self}
      end
      if !new_parent.nil?
        new_parent.children << self
      end
      @parent = new_parent
    end
  end
  
  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "NotMyChildProblem" if child_node.parent != self
    child_node.parent=nil
    @children.reject! {|child| child == child_node}
  end

  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child|
      child_result = child.dfs(target_value)
      return child_result if !child_result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = []
    queue.push(self)
    until queue.empty?
      ele = queue.shift 
      return ele if ele.value == target_value
      ele.children.each {|child| queue.push(child)}
    end 
    return nil 
  end 

end

