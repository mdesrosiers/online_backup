require 'online_backup/runner'
require 'online_backup/store'

describe OnlineBackup::Runner do

  options = OnlineBackup::Options.new
  options.directory = "."
  options.bucket = "my-bucket"

  subject { OnlineBackup::Runner.new(options) }

  describe "#run" do
    it "should save files" do
      OnlineBackup::Store.should_receive(:connect)
      OnlineBackup::Store.should_receive(:bucket_exists?).and_return(true)
      Dir.should_receive(:glob).with("./**").and_yield(__FILE__)
      OnlineBackup::Store.should_receive(:save)

      subject.run
    end

    it "shouldn't save directories" do
      OnlineBackup::Store.should_receive(:connect)
      OnlineBackup::Store.should_receive(:bucket_exists?).and_return(true)
      Dir.should_receive(:glob).with("./**").and_yield(File.dirname(__FILE__))
      OnlineBackup::Store.should_not_receive(:save)

      subject.run
    end
  end

end
