# frozen_string_literal: true

require 'fastimage'

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
    explicit = current_page.data.description.to_s.strip
    return explicit unless explicit.empty?

    if current_article
      tagline = current_article.data.tagline.to_s.strip
      return tagline unless tagline.empty?

      body = current_article.respond_to?(:body) ? current_article.body.to_s : ''
      text = body.gsub(/<[^>]+>/, ' ').gsub(/\s+/, ' ').strip
      return text.length > 155 ? "#{text[0, 154].rstrip}…" : text unless text.empty?
    end

    I18n.t('site.description')
  end

  def page_keywords
    I18n.t('site.keywords')
  end

  def page_author
    I18n.t('site.author')
  end

  def page_image
    File.join(data.settings.site.domain, data.settings.site.og_image)
  end

  def canonical_url
    File.join(data.settings.site.domain, current_page.url)
  end

  def image_dimensions(path)
    FastImage.size(File.join('source', 'assets', 'images', path)) || []
  end

  def json_ld
    if current_page_type == :article
      {
        '@context' => 'https://schema.org',
        '@type' => 'BlogPosting',
        'headline' => current_page.data.title,
        'description' => page_description,
        'datePublished' => current_article.date.iso8601,
        'dateModified' => current_article.date.iso8601,
        'mainEntityOfPage' => { '@type' => 'WebPage', '@id' => canonical_url },
        'author' => { '@type' => 'Person', 'name' => page_author, 'url' => data.settings.site.domain },
        'publisher' => { '@type' => 'Person', 'name' => page_author },
        'image' => page_image,
        'keywords' => Array(current_article.tags).join(', '),
        'inLanguage' => 'en'
      }
    else
      {
        '@context' => 'https://schema.org',
        '@type' => 'ProfessionalService',
        'name' => page_author,
        'url' => data.settings.site.domain,
        'description' => page_description,
        'image' => page_image,
        'jobTitle' => 'Fractional CTO & Software Consultant',
        'address' => { '@type' => 'PostalAddress', 'addressLocality' => 'Madrid', 'addressCountry' => 'ES' },
        'sameAs' => data.settings.services.values
      }
    end
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
