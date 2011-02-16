require 'yaml'

module OnlineBackup
  class History

    DATA_FILE = File.expand_path("~/.online_backup")

    def initialize(data_file = nil)
      @data_file = data_file || DATA_FILE
      load
    end

    def get(key)
      @entries[key]
    end

    def contains?(key)
      not get(key).nil?
    end

    def set(key, value)
      @entries[key] = value
    end

    def dump
      File.open(@data_file, 'w' ) { |out| YAML.dump(@entries, out) }
    end

    private

    def load
      if File.exists? @data_file then
        @entries = File.open(@data_file, 'r+') { |f| YAML::load(f) }
      else
        @entries = {}
      end
    end
  end
end