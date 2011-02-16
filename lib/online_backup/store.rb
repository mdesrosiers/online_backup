require 'aws/s3'

module OnlineBackup
  class Store

    BUCKET_NAME = ENV['AMAZON_BUCKET_NAME']

    class << self

      def connect
        AWS::S3::Base.establish_connection!(access_key_id: ENV['AMAZON_ACCESS_KEY_ID'], secret_access_key: ENV['AMAZON_SECRET_ACCESS_KEY'])
      end

      def bucket_exists?
        AWS::S3::Service.buckets.index { |b| b.name == BUCKET_NAME }.nil?
      end

      def create_bucket
        AWS::S3::Bucket.create(BUCKET_NAME)
      end

      def save(file)
        AWS::S3::S3Object.store(file, open(file), BUCKET_NAME)
      end
    end
  end
end