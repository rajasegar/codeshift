require 'optparse'
require 'codeshift/codeshift_options'
require 'codeshift/codeshift_transformer'
require 'codeshift/version'
require 'open-uri'

module CodeShift
  class CLI
    def initialize
      @options = Codeshift::CodeshiftOptions.new
      OptionParser.new do |opts|
        opts.banner = "Usage: codeshift -t <transform-file> [path]"

        opts.on("--version", "Print version number") do |q|
          puts Codeshift::VERSION
          exit
        end

        opts.on("-tTRANSFORM", "--transform=TRANSFORM", "path to the transform file. Can be either a local path or url\n (default: ./transform.rb)") do |f|

          @options.transform = f
        end

        opts.on("-h", "--help", "Prints this help") do
          puts opts
          exit
        end
      end.parse!

      @files = ARGV
    end

    def run
      paths = @files.length > 0 ? @files : []
      paths.each do |path|
        if File.directory?(path)
          Dir.glob(path) do |file_path|
            puts "Processing: #{file_path}"
            code = File.read(file_path)
            transform = open(@options.transform) { |f| f.read } 
            output = Codeshift::CodeshiftTransformer.new(code, transform).transform
            File.write(file_path, output)
          end
        else
          puts "Processing: #{path}"
          code = File.read(path)
          transform = open(@options.transform) { |f| f.read } 
          output = Codeshift::CodeshiftTransformer.new(code, transform).transform
          File.write(path, output)
        end
      end
    end
  end
end
