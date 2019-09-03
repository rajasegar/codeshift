# Paste some ruby code here and
# # check the generated AST on the right
tips = [
  "Click on any AST node with a '+' to expand it",

  "Hovering over a node highlights the \
     corresponding part in the source code",
]
def print_tips
  tips.each { |key, value| print "Tip #{key}: #{value}" }
end

