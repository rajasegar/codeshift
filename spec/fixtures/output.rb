# Paste some ruby code here and
# # check the generated AST on the right
spit = [
  "Click on any AST node with a '+' to expand it",

  "Hovering over a node highlights the \
     corresponding part in the source code",
]
def spit_tnirp
  tips.each { |key, value| print "Tip #{key}: #{value}" }
end

