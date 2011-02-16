# Online Backup 

## Description

This is a simple command line tool used to backup files to Amazon S3. Currently it only copies all files inside a specified directory in a given bucket.

The assumptions are that:

* You already have your AWS access key id and your secret access key and that their value has been set as environment variables. See AWS::S3 library [documentation](http://amazon.rubyforge.org/) for details.
* The bucket specified has already been created in your Amazon S3 account and is available as an environment variable named AMAZON_BUCKET_NAME

## Usage

    $ ruby -I lib/ bin/online_backup [options] directories...
