# encoding: utf-8

module CustomHelpers
  def draw_page_title
    [data.settings.site.name, data.page.title].reject(&:blank?).join(': ')
  end

  def draw_page_nav
    markup = []

    %w(services methodology contact).each do |page|
      markup << link_to(page_title_map[page.to_sym], "/#{page}", :class => ['btn btn-primary', page_status(page)].join(' '))
    end

    markup.join(' ')
  end

  def page_title_map
    { :services => 'Servicios', :methodology => 'Metodología', :contact => 'Contacto' }
  end

  def page_status page
    (data.page.item === page) ? 'active' : 'inactive'
  end

  def gravatar_for email_address, size = 80
    hash = Digest::MD5.hexdigest(email_address.downcase)

    "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
end
