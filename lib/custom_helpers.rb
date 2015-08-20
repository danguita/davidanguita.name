# encoding: utf-8

module CustomHelpers
  # -- Layout
  def draw_page_title
    ['site.title', draw_layout_page_title].reject(&:blank?).map do |element|
      I18n.t(element)
    end.join(': ')
  end

  def draw_layout_page_title
    "layout.#{data.page.title}" if data.page.title
  end

  def draw_page_nav
    site_pages.map do |page|
      content_tag(:div, class: 'nav__item') do
        link_to(
          I18n.t("layout.#{page}"),
          path_for(page),
          class: ['nav__link', page_status(page)].join(' ')
        )
      end
    end.join(' ')
  end

  def draw_locale_select
    available_locales.map do |locale|
      link_url = '/'
      link_url << locale.to_s unless default_locale?(locale)

      if active_locale?(locale)
        content_tag(:span, I18n.t("locale.#{locale}"), class: 'active')
      else
        content_tag(:a, I18n.t("locale.#{locale}"), href: link_url)
      end
    end.join(' ')
  end

  # -- Paths
  def locale_base_path
    path = Array.new(1, nil)

    path << I18n.locale unless default_locale?(I18n.locale)
  end

  def path_for(page)
    [locale_base_path, "#{page}.html"].join('/')
  end

  def home_path
    path_for('index')
  end

  def projects_path
    path_for('projects')
  end

  def contact_path
    path_for('contact')
  end

  def about_site_path
    path_for('about-site')
  end

  # -- Locale
  def locale_status(locale)
    active_locale?(locale) ? 'active' : 'inactive'
  end

  def active_locale?(locale)
    I18n.locale == locale
  end

  def default_locale?(locale)
    default_locale == locale
  end

  def available_locales
    %i(en es)
  end

  def default_locale
    :en
  end

  # -- Page
  def page_status(page)
    active_page?(page) ? 'active' : 'inactive'
  end

  def active_page?(page)
    (File.basename(current_page.path, current_page.ext) == page) ||
      data.page.title == page
  end

  def site_pages
    %w(services methodology projects)
  end

  # -- Misc
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
