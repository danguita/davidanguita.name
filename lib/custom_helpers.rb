# encoding: utf-8

module CustomHelpers
  def draw_page_title
    [I18n.t('site.name'), data.page.title].reject(&:blank?).join(': ')
  end

  def draw_page_nav
    markup = []

    %w(services methodology contact).each do |page|
      markup << link_to(I18n.t(page), "#{page}.html", :class => ['btn btn-primary', page_status(page)].join(' '))
    end

    markup.join(' ')
  end

  def page_title_map
    { :services => 'Servicios', :methodology => 'Metodología', :contact => 'Contacto' }
  end

  def page_status page
    is_active?(page) ? 'active' : 'inactive'
  end

  def is_active? page
    File.basename(current_page.path, current_page.ext) === page
  end

  def gravatar_for email_address, size = 80
    hash = Digest::MD5.hexdigest(email_address.downcase)

    "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
end
