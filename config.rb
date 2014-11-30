###
# Global settings
###

activate :i18n, :mount_at_root => :en

activate :directory_indexes

###
# Compass
###

# Change Compass configuration
compass_config do |config|
 config.output_style = :compact
end

###
# Page options, layouts, aliases and proxies
###

# Dynamic pages: Projects
data.projects.en.each do |key, _|
  proxy "/projects/#{key}.html", "/localizable/projects/template.html", :locals => { :key => key }, :lang => :en, :ignore => true
  proxy "/es/projects/#{key}.html", "/localizable/projects/template.html", :locals => { :key => key }, :lang => :es, :ignore => true
end

# Ignore proxied templates
ignore "projects/template.html"
ignore "es/projects/template.html"

# Sitemap
page "/sitemap.xml", :layout => false

# HTTP 404 Not Found (I really want the extension)
page "/404.html", :directory_index => false
ignore "es/404.html"

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
end
