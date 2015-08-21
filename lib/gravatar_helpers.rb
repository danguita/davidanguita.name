# encoding: utf-8

module GravatarHelpers
  def gravatar_url_for(email_address, size = 72)
    email_hash = Digest::MD5.hexdigest(email_address.downcase)

    "http://www.gravatar.com/avatar/#{email_hash}?s=#{size}"
  end

  def my_gravatar
    image_tag(
      gravatar_url_for(data.settings.contact.email, 200),
      alt: 'David Anguita',
      width: 100,
      height: 100
    )
  end
end
