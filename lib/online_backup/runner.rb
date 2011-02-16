require_relative 'history'
require_relative 'store'

module OnlineBackup
  class Runner

    def initialize(options)
      @options = options
      @history = History.new @options.data_file
    end

    def run
      Store.connect
      Store.create_bucket unless Store.bucket_exists?

      @options.directories.each do |d|
        Dir.glob("#{d}/**".squeeze("/")) do |f|
          unless File.directory? f or @history.contains? f
            response = Store.save f
            @history.set(f, {etag: response["etag"], date: response["date"]})
          end
        end
      end

      @history.dump
    end
  end
end