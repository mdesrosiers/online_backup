require 'online_backup/store'
require 'aws/s3'

describe OnlineBackup::Store do
  subject { OnlineBackup::Store.new :bucket }
  its(:bucket) { should eq (:bucket) }

  describe "#save" do
    it "delegates to S3Object.store" do
      file = 'test.txt'
      bucket = AWS::S3::Bucket.new(name: "bucket-name")

      AWS::S3::Base.should_receive(:establish_connection!)
      AWS::S3::Service.should_receive(:buckets).and_return([bucket])
      subject.should_receive(:open).with(file).and_return(:file)
      AWS::S3::S3Object.should_receive(:store).with(file, :file, :bucket).and_return(:s3_response)

      subject.save(file).should eq(:s3_response)
    end
  end

end
