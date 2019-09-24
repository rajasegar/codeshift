# frozen_string_literal: true

require 'parser/current'

module Codeshift
  # Transformer Class
  class Transformer
    def initialize(code, transform)
      @code = code
      @transform = transform
    end

    def transform
      eval(@transform)

      buffer        = Parser::Source::Buffer.new('(example)')
      buffer.source = @code
      begin
        temp = Parser::CurrentRuby.parse(@code)
        rewriter = Transform.new

        # Rewrite the AST, returns a String with the new form.
        output = rewriter.rewrite(buffer, temp)
      rescue
        puts 'Unknown parsing error'
        @code
      end
    end
  end
end
