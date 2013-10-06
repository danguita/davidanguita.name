# encoding: utf-8

module CustomHelpers

  # -- Layout
  def draw_page_title
    ['site.title', draw_layout_page_title].reject(&:blank?).
      map { |element| I18n.t(element) }.join(': ')
  end

  def draw_layout_page_title
    "layout.#{data.page.title}" if data.page.title
  end

  def draw_page_nav
    available_pages.map do |page|
      link_to(I18n.t("layout.#{page}"), page_path(page),
              class: ['btn btn-primary btn-large', page_status(page)].join(' '))
    end.join(' ')
  end

  def draw_locale_select
    available_locales.map do |locale|
      target = '/'
      target << locale.to_s unless default_locale?(locale)

      if active_locale? locale
        content_tag(:span, I18n.t("locale.#{locale}"), class: 'active')
      else
        link_to(I18n.t("locale.#{locale}"), target)
      end
    end.join(' ')
  end

  # -- Paths
  def locale_base_path
    path = [nil]

    path << I18n.locale unless default_locale?(I18n.locale)
  end

  def page_path(page)
    [locale_base_path, "#{page}.html"].join('/')
  end

  def home_path
    page_path 'index'
  end

  def projects_path
    page_path 'projects'
  end

  def contact_path
    page_path 'contact'
  end

  # -- Locale
  def locale_status(locale)
    active_locale?(locale) ? 'active' : 'inactive'
  end

  def active_locale?(locale)
    I18n.locale === locale
  end

  def default_locale?(locale)
    default_locale === locale
  end

  def available_locales
    [:en, :es]
  end

  def default_locale
    :es
  end

  # -- Page
  def page_status(page)
    active_page?(page) || data.page.title == page ? 'active' : 'inactive'
  end

  def active_page?(page)
    File.basename(current_page.path, current_page.ext) === page
  end

  def available_pages
    %w( services methodology projects )
  end

  # -- Utils
  def gravatar_for(email_address, size = 72)
    hash = Digest::MD5.hexdigest(email_address.downcase)

    "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
end
