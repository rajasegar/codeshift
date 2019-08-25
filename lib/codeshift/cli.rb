require 'optparse'

module CodeShift
  class CLI
    def initialize
      OptionParser.new do |opts|
        opts.banner = "Usage: codeshift -t <transform-file> [path]"

        opts.on("--version", "Print version number") do |q|
          puts Codeshift::VERSION
          exit
        end
      end
    end

    def run
      puts "hello world"
    end
  end
end
