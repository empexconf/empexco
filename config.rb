require "addressable/uri"

###
# Page options, layouts, aliases and proxies
###
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :partials_dir, 'partials'

set :markdown_engine, :redcarpet

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration
activate :directory_indexes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload

  set :segment_id, "wjgcEjr9l62PIrXXgtJapxrLYFYTsF40"
end

###########################
## Organizers
###########################

activate :blog do |blog|
  blog.name = "organizers"
  blog.prefix = 'organizers'
  blog.permalink = '{year}/{title}'
  blog.taglink = "tags/{tag}"
  blog.default_extension = ".md"
  blog.layout   = "post"
  blog.paginate = true
  blog.per_page = 10
end

#######
# Build
#######

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :gzip, exts: %w(.js .css .html .htm .svg .ttf .otf .woff .eot)

  set :segment_id, "zjDir8SGfEhikBBIlTqmXCwJxgjUICxk"
  set :host, "http://empex.co"
end

#########
# Helpers
#########

helpers do
  def tweet_link_to(text, params = {})
    uri = Addressable::URI.parse("https://twitter.com/intent/tweet")
    uri.query_values = params
    link_to text, uri, target: "_blank"
  end

  def asset_url(kind, source, opts = {})
    host + asset_path(kind, source, opts)
  end

  def host
    config[:host] || ""
  end

  def link_to_link(url)
    uri = Addressable::URI.parse(url)
    link_to uri.host, uri, target: "_blank"
  end

  def link_to_twitter(handle)
    link_to "@#{handle}", "https://twitter.com/#{handle}"
  end
end
