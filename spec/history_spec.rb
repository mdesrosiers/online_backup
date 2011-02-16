require 'online_backup/history'

describe OnlineBackup::History do
  describe "#set_entry" do
    it "should update the history" do
      value = { modified_on: DateTime.now, etag: "123456789" }
      File.stub!(:exists?).and_return(false)
      subject.set("test-key", value)
      subject.get("test-key").should equal value
    end

    it "should open the data file when it exists" do
      value = { modified_on: DateTime.now, etag: "123456789" }
      File.stub!(:exists?).and_return(true)
      File.should_receive(:open).and_return({})
      subject.set("test-key", value)
      subject.get("test-key").should equal value
    end
  end
end