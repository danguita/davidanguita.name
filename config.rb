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
activate :asset_hash
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

# Progressive enhancements for article content:
# - lazy-load / async-decode images
# - make scrollable code blocks keyboard-focusable
after_build do
  Dir.glob(File.join('build', 'articles', '**', '*.html')).each do |path|
    html = File.read(path)
    next unless html.include?('<img ') || html.include?('<pre')

    updated = html
      .gsub(/<img (?![^>]*\bloading=)([^>]*)>/) { %(<img loading="lazy" #{$1}>) }
      .gsub(/<img (?![^>]*\bdecoding=)([^>]*)>/) { %(<img decoding="async" #{$1}>) }
      .gsub(/<pre(?![^>]*\btabindex=)(\s|>)/) { %(<pre tabindex="0"#{$1}) }

    File.write(path, updated) if updated != html
  end
end

# Content-Security-Policy hardening: the `_headers` CSP has a
# `%SCRIPT_HASHES%` placeholder in `script-src`. Replace it with the SHA-256
# hashes of every inline <script> in the built output, so the policy can drop
# `'unsafe-inline'` while still allowing the theme-init, analytics and Disqus
# snippets. Regenerated on every build, so editing those scripts stays safe.
after_build do
  require 'set'
  require 'digest'
  require 'base64'

  hashes = Set.new
  Dir.glob(File.join('build', '**', '*.html')).each do |path|
    File.read(path).scan(%r{<script([^>]*)>(.*?)</script>}m) do |attrs, body|
      next if attrs.downcase.include?('src=')
      next if attrs.downcase.include?('application/ld+json')

      hashes << "'sha256-#{Base64.strict_encode64(Digest::SHA256.digest(body))}'"
    end
  end

  headers = File.join('build', '_headers')
  if File.exist?(headers) && hashes.any?
    content = File.read(headers)
    content = content.sub('%SCRIPT_HASHES%', hashes.to_a.sort.join(' '))
    File.write(headers, content)
  end
end

# Templating
set :haml, { format: :html5 }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
