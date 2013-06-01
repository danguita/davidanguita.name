###
# Global settings
###

activate :i18n, :mount_at_root => :es

activate :directory_indexes

###
# Markdown settings
###

set :markdown_engine, :redcarpet
set :markdown, :autolink => true,
               :tables => true,
               :fenced_code_blocks => true

###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
compass_config do |config|
 config.output_style = :compact
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

# Dynamic pages: Projects
data.projects.en.each do |key, _|
  proxy "/projects/#{key}.html", "/localizable/projects/template.html", :locals => { :key => key }, :lang => :es, :ignore => true
  proxy "/en/projects/#{key}.html", "/localizable/projects/template.html", :locals => { :key => key }, :lang => :en, :ignore => true
end

# Ignore proxied templates
ignore "projects/template.html"
ignore "en/projects/template.html"

# Sitemap
page "/sitemap.xml", :layout => false

# Ignore content files (markdown)
ignore "content/*"

# Ignore stylesheet modules
ignore "stylesheets/vendor/*"
ignore "stylesheets/modules/*"

###
# Helpers
###

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# CustomHelpers
require "lib/custom_helpers"
helpers CustomHelpers

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
