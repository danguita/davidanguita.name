Time.zone = "Madrid"

activate :blog do |blog|
  blog.permalink         = "articles/{title}.html"
  blog.sources           = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink           = "articles/tags/{tag}.html"
  blog.layout            = "layouts/article"
  blog.year_link         = "articles/{year}.html"
  blog.month_link        = "articles/{year}/{month}.html"
  blog.day_link          = "articles/{year}/{month}/{day}.html"
  blog.default_extension = ".markdown"
  blog.tag_template      = "tag.html"
  blog.calendar_template = "calendar.html"
  blog.paginate          = true
  blog.per_page          = 10
  blog.page_link         = "articles/page/{num}"
end

activate :i18n, mount_at_root: :en
activate :directory_indexes
activate :automatic_image_sizes
activate :syntax

# Dynamic pages: Projects
data.projects.each do |key, _|
  proxy "/projects/#{key}.html",
    "/projects/template.html",
    locals: { :key => key },
    ignore: true
end

# Ignores
ignore "projects/template.html"
ignore "calendar.html"
ignore "tag.html"
ignore "content/*"

# Sitemap
page "/sitemap.xml", layout: false

# Blog feed
page "/feed.xml", layout: false

# Helpers
require "lib/layout_helpers"
require "lib/route_helpers"
require "lib/gravatar_helpers"

helpers RouteHelpers
helpers LayoutHelpers
helpers GravatarHelpers

# Assets
set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :fonts_dir, "assets/fonts"
set :images_dir, "assets/images"
set :partials_dir, "partials"

# Templating
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
set :haml, { ugly: true, format: :html5 }

# Compass config
compass_config do |config|
 config.output_style = :compact
end

# Build-specific configuration
configure :build do
  # Change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash
end
