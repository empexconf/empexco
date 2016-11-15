require "addressable/uri"

###
# Page options, layouts, aliases and proxies
###
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :partials_dir, 'partials'

set :markdown, autolink: true, tables: true
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

data.events.each do |event_slug, event|
  p event
  if event.current
    proxy "index.html", "current_event.html", locals: { event: event }
  end
end

###########################
## organizers
###########################

activate :blog do |blog|
  blog.name = "organizers"
  blog.prefix = "organizers"
  blog.permalink = "{year}/{title}"
  blog.taglink = "tags/{tag}"
  blog.default_extension = ".md"
  blog.layout   = "layout"
  blog.paginate = true
  blog.per_page = 10
  blog.publish_future_dated = true
end

###########################
## speakers
###########################

activate :blog do |blog|
  blog.name = "speakers"
  blog.prefix = "speakers"
  blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.permalink = "{year}/{title}"
  blog.taglink = "tags/{tag}"
  blog.default_extension = ".md"
  blog.layout   = "speaker"
  blog.paginate = true
  blog.per_page = 10
  blog.publish_future_dated = true
end

###########################
## sponsors
###########################

activate :blog do |blog|
  blog.name = "sponsors"
  blog.prefix = "sponsors"
  blog.permalink = "{year}/{title}"
  blog.taglink = "tags/{tag}"
  blog.default_extension = ".md"
  blog.layout   = "layout"
  blog.paginate = true
  blog.per_page = 10
  blog.publish_future_dated = true
end

###########################
## schedule
###########################

activate :blog do |blog|
  blog.name = "schedule"
  blog.prefix = "schedule"
  blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}"
  blog.default_extension = ".md"
  blog.layout   = "layout"
  blog.paginate = true
  blog.per_page = 20
  blog.publish_future_dated = true
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

class RenderWithoutProtocol < Redcarpet::Render::HTML
  def autolink(url, link_type)
    uri = Addressable::URI.parse(url)
    "<a href=\"#{url}\" target=\"_blank\">#{uri.host}<a>"
  end
end

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

  def link_to_twitter(handle = nil, text = "@#{handle}")
    link_to text, "https://twitter.com/#{handle}" if handle
  end

  def google_api_key
    'AIzaSyDavTubUc7sQx7cvY-NA--jLhQgOrEpgic'
  end

  def autolink(text)
    renderer = RenderWithoutProtocol.new
    markdown = Redcarpet::Markdown.new(renderer, autolink: true)
    markdown.render(text)
  end

  def speakers
    blog("speakers").articles
  end

  def sponsors
    blog("sponsors").articles
  end

  def organizers
    blog("organizers").articles
  end

  def alphabetize speakers
    speakers.sort_by { |s| s.data.title.split(" ").last }
  end

  def sponsors_for level
    sponsors.select {|s| s.data.level == level}
  end

  def crevalle
    sponsors.detect { |s| s.data.level == 'crevalle' }
  end

  def hotel_url
    "https://gc.synxis.com/rez.aspx?Hotel=26762&Chain=10179&group=91320103104"
  end

  def hotel_map_url
    "https://www.google.com/maps/place/70+Park+Ave,+New+York,+NY+10016/@40.7498316,-73.9819411,17z/data=!3m1!4b1!4m2!3m1!1s0x89c259012c91221d:0x601c534f32c7a691"
  end

  def hotel_directions_url
    "https://www.google.com/maps/dir/SubCulture,+Bleecker+Street,+New+York,+NY/70+Park+Ave,+New+York,+NY+10016/@40.734499,-73.9989327,14z/data=!3m1!4b1!4m13!4m12!1m5!1m1!1s0x89c259855d92e7a7:0x24cb3f782848bc74!2m2!1d-73.994291!2d40.7258626!1m5!1m1!1s0x89c259012c91221d:0x601c534f32c7a691!2m2!1d-73.9797524!2d40.7498316"
  end

  def cfp_url
   'https://goo.gl/forms/NtT1TcTAD7GrhW0q1'
  end
end
