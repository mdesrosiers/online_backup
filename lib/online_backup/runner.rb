require_relative 'store'

module OnlineBackup
  class Runner

    def initialize(options)
      @options = options
    end

    def run
      Store.connect

      Store.create_bucket(@options.bucket) unless Store.bucket_exists? @options.bucket

      unless (File.directory? @options.directory)
        STDERR.puts "#{@options.directory} is not a directory"
        exit(-1)
      end

      Dir.glob(@options.directory + "/**") { |f| Store.save(f, @options.bucket) unless File.directory? f }
    end
  end
end