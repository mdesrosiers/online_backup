require_relative 'options'
require_relative 'store'

module OnlineBackup
  class Runner

    def initialize(argv)
      @options = Options.new(argv)
      @store = Store.new(@options.bucket)
    end

    def run
      Dir.glob(@options.directory + "/**") { |f| @store.save f unless File.directory? f }
    end
  end    
end