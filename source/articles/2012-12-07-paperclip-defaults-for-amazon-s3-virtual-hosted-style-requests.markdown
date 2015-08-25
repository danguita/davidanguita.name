---
title: Paperclip defaults for Amazon S3 virtual hosted-style requests
tagline:
date: 2012-12-07 17:47
comments: true
tags: Amazon, S3, AWS, Rails, Paperclip
description:
---

[Paperclip](https://github.com/thoughtbot/paperclip) is a great gem for adding file attachments to your Rails models. It ships with some storage adapters including Amazon S3 but the documentation isn't totally clear for virtual hosted-style requests.

If you need to use classic path-style requests like `http://s3.amazonaws.com/yourbucket`, add these defaults to your environment file:

```ruby
# config/environments/production.rb

config.paperclip_defaults = {
  :storage => :s3,
  :s3_credentials => {
    :bucket => ENV['AWS_BUCKET'],
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }
}
```

Otherwise, if you need to use virtual hosted-style requests like `http://yourbucket.s3.amazonaws.com`, you **must** specify the `path` and `url` options:

```ruby
# config/environments/production.rb

config.paperclip_defaults = {
  :storage => :s3,
  :url => ":s3_domain_url",
  :path => ":class/:id.:style.:extension",
  :s3_credentials => {
    :bucket => ENV['AWS_BUCKET'],
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }
}
```

## Important notes

* For now (`3.3.1`) you will get a `Paperclip::InfiniteInterpolationError` exception if the `path` option is not specified.
* The value of the `url` option must be `":s3_domain_url"` as a string, not as a symbol.
* The `path` option is fully customizable. The shown pattern will produce filepaths like `http://yourbucket.s3.amazonaws.com/images/1.thumb.png`.

## References

* [Paperclip on GitHub](https://github.com/thoughtbot/paperclip#readme)
* [Paperclip::Storage::S3 documentation](http://rubydoc.info/gems/paperclip/Paperclip/Storage/S3)
* [AWS Buckets and Regions](http://docs.amazonwebservices.com/AmazonS3/latest/dev/LocationSelection.html)
