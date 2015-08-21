activate :i18n, mount_at_root: :en
activate :directory_indexes
activate :automatic_image_sizes

# Dynamic pages: Projects
data.projects.en.each do |key, _|
  proxy "/projects/#{key}.html",
    "/localizable/projects/template.html",
    locals: { :key => key },
    lang: :en,
    ignore: true

  proxy "/es/projects/#{key}.html",
    "/localizable/projects/template.html",
    locals: { :key => key },
    lang: :es,
    ignore: true
end

# Ignore proxied templates
ignore "projects/template.html"
ignore "es/projects/template.html"

# Sitemap
page "/sitemap.xml", layout: false

# Ignore content files (markdown)
ignore "content/*"

# Ignore stylesheet modules
ignore "stylesheets/vendor/*"
ignore "stylesheets/modules/*"

# Helpers
require "lib/layout_helpers"
require "lib/route_helpers"
require "lib/locale_helpers"
require "lib/gravatar_helpers"

helpers RouteHelpers
helpers LayoutHelpers
helpers LocaleHelpers
helpers GravatarHelpers

# Assets
set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :fonts_dir, "assets/fonts"
set :images_dir, "assets/images"
set :partials_dir, "partials"

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
  activate :cache_buster
end
