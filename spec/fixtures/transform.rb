# Your Transform Class should always extend from 
# # Parser:: TreeRewriter
class Transform < Parser::TreeRewriter
  def on_lvasgn(node)
    # Reverse the variable names
    replace(node.loc.to_hash[:name], node.children[0].to_s.reverse)
  end

  def on_def(node)
    replace(node.loc.to_hash[:name], node.children[0].to_s.reverse)
  end
end

