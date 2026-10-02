# frozen_string_literal: true

Time.zone = 'Madrid'

activate :blog do |blog|
  blog.permalink         = 'articles/{title}.html'
  blog.sources           = 'articles/{year}-{month}-{day}-{title}.html'
  blog.taglink           = 'articles/tags/{tag}.html'
  blog.layout            = 'layouts/article'
  blog.year_link         = 'articles/{year}.html'
  blog.month_link        = 'articles/{year}/{month}.html'
  blog.day_link          = 'articles/{year}/{month}/{day}.html'
  blog.default_extension = '.markdown'
  blog.tag_template      = 'tag.html'
  blog.calendar_template = 'calendar.html'
  blog.paginate          = true
  blog.per_page          = 10
  blog.page_link         = 'articles/page/{num}'
end

# Extensions
activate :i18n, mount_at_root: :en
activate :directory_indexes
activate :syntax

# Ignored pages
ignore 'calendar.html'
ignore 'tag.html'
ignore 'content/*'

# Sitemap
page '/sitemap.xml', layout: false

# Blog feed
page '/feed.xml', layout: false

# Explicitly build `_redirects` and `_headers` files
import_file File.expand_path('_redirects', config[:source]), '/_redirects'
import_file File.expand_path('_headers', config[:source]), '/_headers'

# Custom helpers
require 'lib/layout_helpers'
require 'lib/route_helpers'
require 'lib/gravatar_helpers'
require 'lib/icon_helpers'

helpers RouteHelpers
helpers LayoutHelpers
helpers GravatarHelpers
helpers IconHelpers

# Assets
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :fonts_dir, 'assets/fonts'
set :images_dir, 'assets/images'

# Add lazy-loading to content images (e.g. article screenshots)
after_build do
  Dir.glob(File.join('build', 'articles', '**', '*.html')).each do |path|
    html = File.read(path)
    next unless html.include?('<img ')

    updated = html
      .gsub(/<img (?![^>]*\bloading=)([^>]*)>/) { %(<img loading="lazy" #{$1}>) }
      .gsub(/<img (?![^>]*\bdecoding=)([^>]*)>/) { %(<img decoding="async" #{$1}>) }

    File.write(path, updated) if updated != html
  end
end

# Templating
set :haml, { format: :html5 }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
