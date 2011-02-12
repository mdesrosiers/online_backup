require 'online_backup/options'

describe OnlineBackup::Options do

  before(:all) do
    $stdout = StringIO.new
  end

  describe "#parse" do
    it "should exit cleanly if no options are provided" do
      lambda { subject.parse([]) }.should raise_error SystemExit
    end

    it "should exit cleanly if -h is provided" do
      lambda { subject.parse(["-h"]) }.should raise_error SystemExit
    end
  end

  it "should set the required attributes" do
    directory = "."
    bucket_name = "bucket"

    subject.parse(["-d", directory, "-b", bucket_name])

    subject.directory.should eq(directory)
    subject.bucket.should eq(bucket_name)
  end

  after(:all) do
    $stdout = STDOUT
  end
end