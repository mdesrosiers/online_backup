require 'yaml'

module OnlineBackup
  class History

    DATA_FILE = File.expand_path("~/.online_backup")

    def initialize(data_file = nil)
      @data_file = data_file || DATA_FILE
      load
    end

    def get(file)
      @entries[file]
    end

    def contains?(file)
      not get(file).nil?
    end

    def outdated?(file)
      modified_time = File.mtime(file)
      backup_time = Time.parse(get(file)[:date])
      modified_time > backup_time
    end

    def update(file, response)
      set(file, {etag: response["etag"], date: response["date"]})
    end

    def set(file, value)
      @entries[file] = value
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