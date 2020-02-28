# frozen_string_literal: true

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
        current_page.data.title &&
          I18n.t("layout.#{current_page.data.title}"),
        I18n.t('site.author')
      ].compact.join(separator)
    when :index_page
      I18n.t('site.title')
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

  def index_page?
    current_page.path == 'index.html'
  end

  def current_page_type
    if @current_tag
      :tag
    elsif @current_date
      :calendar
    elsif current_article
      :article
    else
      index_page? ? :index_page : :page
    end
  end
end
