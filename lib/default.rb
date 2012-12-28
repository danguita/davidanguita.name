# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

require "digest/md5"

def gravatar email_address, size = 80
  hash = Digest::MD5.hexdigest(email_address.downcase)

  "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
end
