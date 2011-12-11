# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

require "digest/md5"

def gravatar(email_address, size = nil)
  hash = Digest::MD5.hexdigest(email_address)
  return "http://www.gravatar.com/avatar/#{hash}"
end