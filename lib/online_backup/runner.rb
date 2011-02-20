require 'logger'
require_relative 'history'
require_relative 'store'

module OnlineBackup
  class Runner

    def initialize(options)
      @options = options
      @history = History.new @options.data_file
      @log = Logger.new(STDOUT)
    end

    def run
      Store.connect
      Store.create_bucket unless Store.bucket_exists?

      @options.directories.each do |d|
        Dir.glob("#{d}/**".squeeze("/")) do |f|
          unless File.directory? f
            backup f
          end
        end
      end

      @history.dump
    end

    private

    def backup(file)
      if !@history.contains? file or @history.outdated? file
        @log.info "saving #{file}"
        response = Store.save file
        @history.update(file, response)
      end
    end
  end
end