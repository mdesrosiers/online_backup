require 'optparse'

module OnlineBackup
  class Options

    attr_accessor :directories, :data_file

    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = "Usage: online_backup [options] directories..."

        opts.on("-d", "--data-file [DATA_FILE]", "Local data file used to store backup history, defaults to ~/.online_backup.") do |d|
          @data_file = d
        end

        opts.on("-h", "--help", "Show this message.") do
          puts opts
          exit
        end

        begin argv << "-h" if argv.empty?
          opts.parse!(argv)
          @directories = argv 
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end
    end
  end
end