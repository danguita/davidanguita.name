# encoding: utf-8

module LayoutHelpers
  def page_title
    separator = ' - '

    case current_page_type
    when :tag
      [
        "Articles tagged #{@current_tag}",
        I18n.t('site.author')
      ].join(separator)
    when :calendar
      [
        "Archive for #{@current_date}",
        I18n.t('site.author')
      ].join(separator)
    when :article
      [
        current_page.data.title,
        I18n.t('site.author')
      ].join(separator)
    when :page
      [
        I18n.t('site.title'),
        (I18n.t("layout.#{current_page.data.title}") if current_page.data.title),
        (@page_title if @page_title)
      ].compact.join(separator)
    end
  end

  def page_description
    return current_page.data.description if current_page.data.description
    return @page_description if @page_description

    I18n.t('site.description')
  end

  def page_keywords
    I18n.t('site.keywords')
  end

  def page_author
    I18n.t('site.author')
  end

  def page_image
    gravatar_url_for(data.settings.contact.email, 200)
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

  def current_page_type
    if @current_tag
      :tag
    elsif @current_date
      :calendar
    elsif current_article
      :article
    else
      :page
    end
  end
end
