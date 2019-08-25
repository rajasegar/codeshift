module Codeshift
  class CodeshiftOptions
    attr_accessor :file_path
    attr_accessor :transform

    def initialize
      @file_path = nil
      @transform = "./transform.rb"
    end


  end
end
