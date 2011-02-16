require 'online_backup/options'

describe OnlineBackup::Options do

  before(:all) do
    $stdout = StringIO.new
  end

  describe "#parse" do
    it "should exit cleanly if no options are provided" do
      lambda { subject.parse [] }.should raise_error SystemExit
    end

    it "should exit cleanly if -h is provided" do
      lambda { subject.parse ["-h"] }.should raise_error SystemExit
    end
  end

  it "should set the required attributes" do
    subject.parse ["-d", "~/.online_backup", ".", "/tmp"]
    subject.data_file.should eq("~/.online_backup")
    subject.directories.should eq([".", "/tmp"])
  end

  after(:all) do
    $stdout = STDOUT
  end
end