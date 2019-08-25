require 'parser/current'

module Codeshift
  class CodeshiftTransformer
    def initialize(code, transform)
      @code = code
      @transform = transform
    end

    def transform
      eval(@transform)

      buffer        = Parser::Source::Buffer.new('(example)')
      buffer.source = @code
      temp = Parser::CurrentRuby.parse(@code)
      rewriter      = Transform.new

      # Rewrite the AST, returns a String with the new form.
      output =  rewriter.rewrite(buffer, temp)

    end
  end
end
