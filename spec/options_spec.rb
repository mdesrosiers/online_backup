require 'online_backup/options'

describe OnlineBackup::Options do

  describe "#initialize" do
    it "should exit cleanly if no options are provided" do
      lambda { OnlineBackup::Options.new([]) }.should raise_error SystemExit
    end

    it "should exit cleanly if -h is provided" do
      lambda { OnlineBackup::Options.new(["-h"]) }.should raise_error SystemExit
    end
  end

    it "should set the required attributes" do
      directory = "/tmp/test"
      bucket_name = "bucket"
      
      options = OnlineBackup::Options.new(["-d", directory, "-b", bucket_name])

      options.directory.should eq(directory)
      options.bucket.should eq(bucket_name)
    end

end
