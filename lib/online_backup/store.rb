require 'aws/s3'

module OnlineBackup
  class Store
    class << self

      def save(file, bucket)
        AWS::S3::S3Object.store(file, open(file), bucket)
      end

      def connect
        AWS::S3::Base.establish_connection!(access_key_id: ENV['AMAZON_ACCESS_KEY_ID'], secret_access_key: ENV['AMAZON_SECRET_ACCESS_KEY'])
      end

      def bucket_exists?(bucket)
        AWS::S3::Service.buckets.index { |b| b.name == @bucket }.nil?
      end

      def create_bucket(bucket)
        AWS::S3::Bucket.create(@bucket)
      end
    end
  end
end