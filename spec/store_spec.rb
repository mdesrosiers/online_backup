require 'online_backup/store'
require 'aws/s3'

describe OnlineBackup::Store do

  describe "#save" do
    it "should delegate to S3Object.store" do
      file = 'test.txt'

      OnlineBackup::Store.should_receive(:open).with(file).and_return(:file)
      AWS::S3::S3Object.should_receive(:store).with(file, :file, anything()).and_return(:s3_response)

      OnlineBackup::Store.save(file).should eq(:s3_response)
    end
  end

end
