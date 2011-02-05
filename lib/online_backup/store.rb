require 'aws/s3'

module OnlineBackup
  class Store

    attr_reader :bucket

    def initialize(bucket)
      @bucket = bucket

      connect
      create_bucket unless bucket_exists?
    end

    def save(file)
      AWS::S3::S3Object.store(file, open(file), @bucket)
    end

    private

    def connect
      AWS::S3::Base.establish_connection!(access_key_id: ENV['AMAZON_ACCESS_KEY_ID'], secret_access_key: ENV['AMAZON_SECRET_ACCESS_KEY'])
    end

    def bucket_exists?
      AWS::S3::Service.buckets.index { |b| b.name == @bucket }.nil?
    end

    def create_bucket
      AWS::S3::Bucket.create(@bucket)
    end
  end
end