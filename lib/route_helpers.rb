# frozen_string_literal: true

module RouteHelpers
  def path_for(page)
    "/#{page}.html"
  end

  def home_path
    path_for('index')
  end

  def contact_path
    path_for('contact')
  end

  def articles_path
    path_for('articles')
  end

  def archive_path
    articles_path
  end

  def now_path
    path_for('now')
  end

  def plays_path
    path_for('plays')
  end

  def page_status(page)
    active_page?(page) ? 'active' : 'inactive'
  end

  def active_page?(page)
    (File.basename(current_page.path, current_page.ext) == page) ||
      data.page.title == page
  end

  def home_page?
    home_page_urls.include?(current_page.url)
  end

  def home_page_urls
    ['/']
  end
end
