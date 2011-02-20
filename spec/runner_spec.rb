require 'online_backup/runner'
require 'online_backup/store'

describe OnlineBackup::Runner do
  options = OnlineBackup::Options.new
  options.directories = (1..3).to_a
  options.data_file = "~/.online_backup"
  subject { OnlineBackup::Runner.new options }

  describe "#run" do
    it "should save files" do
      OnlineBackup::Store.stub!(:connect)
      OnlineBackup::Store.stub!(:bucket_exists?).and_return(true)
      Dir.stub!(:glob).and_yield(__FILE__)
      OnlineBackup::Store.should_receive(:save).exactly(options.directories.length).times.and_return Hash.new
      history = mock("History")
      history.stub!(:contains?)
      history.stub!(:update)
      history.stub!(:dump)
      OnlineBackup::History.stub!(:new).and_return history

      subject.run
    end

    it "shouldn't save directories" do
      OnlineBackup::Store.stub!(:connect)
      OnlineBackup::Store.stub!(:bucket_exists?).and_return(true)
      Dir.should_receive(:glob).exactly(options.directories.length).times.and_yield(File.dirname(__FILE__))
      OnlineBackup::Store.should_not_receive(:save)
      history = mock("History")
      history.stub!(:contains?)
      history.stub!(:update)
      history.stub!(:dump)
      OnlineBackup::History.stub!(:new).and_return history

      subject.run
    end
  end

end
