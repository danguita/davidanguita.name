###
# General options
###

activate :directory_indexes

###
# Markdown
###

set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true, :with_toc_data => false
set :markdown_engine, :redcarpet

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

helpers do
  def draw_page_title
    ['David Anguita. Desarrollador de software y consultor independiente', data.page.title].reject(&:blank?).join(': ')
  end

  def draw_page_nav
    markup = []

    %w(services methodology contact).each do |page|
      markup << link_to(page_title_map[page.to_sym], "/#{page}", :class => ['btn btn-primary', page_status(page)].join(' '))
    end

    markup.join(' ')
  end

  def page_title_map
    { :services => 'Servicios', :methodology => 'Metodología', :contact => 'Contacto' }
  end

  def page_status page
    (data.page.item === page) ? 'active' : 'inactive'
  end

  def gravatar_for email_address, size = 80
    hash = Digest::MD5.hexdigest(email_address.downcase)

    "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
end

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
