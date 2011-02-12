require_relative 'store'

module OnlineBackup
  class Runner

    def initialize(options)
      @options = options
    end

    def run
      Store.connect

      Store.create_bucket(@options.bucket) unless Store.bucket_exists? @options.bucket

      Dir.glob(@options.directory + "/**") do |f|
        Store.save(f, @options.bucket) unless File.directory? f
      end
    end
  end
end