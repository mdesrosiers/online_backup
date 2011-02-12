require 'optparse'

module OnlineBackup
  class Options

    attr_accessor :directory, :bucket

    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = "Usage: online_backup.rb [options]"

        opts.on("-d", "--directory [DIRECTORY]", "Directory to backup") do |d|
          @directory = d

          unless (File.directory? @directory)
            STDERR.puts "#{@directory} is not a directory"
            exit(-1)
          end
        end

        opts.on("-b", "--bucket [BUCKET]", "Bucket name") do |b|
          @bucket = b
        end

        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        begin argv << "-h" if argv.empty?
          opts.parse!(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end
    end
  end
end