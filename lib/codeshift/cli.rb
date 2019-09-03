# frozen_string_literal: true

require 'optparse'
require 'codeshift/options'
require 'codeshift/transformer'
require 'codeshift/version'
require 'open-uri'

module CodeShift
  # Cli Class
  class CLI
    def initialize
      @options = Codeshift::Options.new
      OptionParser.new do |opts|
        opts.banner = 'Usage: codeshift -t <transform-file> [path]'

        opts.on('--version', 'Print version number') do
          puts Codeshift::VERSION
          exit
        end

        opts.on('-tTRANSFORM', '--transform=TRANSFORM', 'path to the transform file. Can be either a local path or url\n (default: ./transform.rb)') do |f|
          @options.transform = f
        end

        opts.on("-h", "--help", "Prints this help") do
          puts opts
          exit
        end
      end.parse!

      @files = ARGV
    end

    def process_file(file_path)
      puts "Processing: #{file_path}"
      code = File.read(file_path)
      transform = open(@options.transform, '&:read')
      output = Codeshift::Transformer.new(code, transform).transform
      File.write(file_path, output)
    end

    def run
      paths = @files.!empty? ? @files : []
      paths.each do |path|
        if File.directory?(path)
          Dir.glob(path) do |file_path|
            process_file file_path
          end
        else
          process_file path
        end
      end
    end
  end
end
