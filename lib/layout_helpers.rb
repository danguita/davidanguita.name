# encoding: utf-8

module LayoutHelpers
  def page_title
    ['site.title', layout_page_title].reject(&:blank?).map do |element|
      I18n.t(element)
    end.join(': ')
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

  def layout_page_title
    "layout.#{data.page.title}" if data.page.title
  end
end
