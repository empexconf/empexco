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

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload

  set :segment_id, "wjgcEjr9l62PIrXXgtJapxrLYFYTsF40"
end

data.events.each do |year, events|
  events.each do |slug, event|
    proxy "events/#{year}/#{slug}.html", "event.html", locals: { event: event, year: year, slug: slug }, ignore: true
    if event.current
      proxy "nyc.html", "current_event.html", locals: { event: event, year: year, slug: slug }, ignore: true
    end
  end
end

data.talks.each do |city, years|
  years.each do |year, talks|
    talks.each do |slug, talk|
      proxy "talks/#{slug}", "talk.html", locals: { talk: talk, slug: slug }, ignore: true
    end
  end
end

page 'index.html', layout: false
page 'la.html', layout: false
page 'la-*.html', layout: false

ignore "current_event.html"
ignore "event.html"

#######
# Build
#######

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  #activate :gzip, exts: %w(.js .css .html .htm .svg .ttf .otf .woff .eot)

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

MarkdownRenderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

helpers do
  def profile_image(author)
    "images/people/presenters/#{author.profile_url}"
  end

  def embedded_video(talk)
    "https://www.youtube.com/embed/#{talk.youtube_id}?rel=0"
  end

  def video_preview_image(talk)
    "https://img.youtube.com/vi/#{talk.youtube_id}/mqdefault.jpg"
  end

  # Format the date like "Monday, June 7"
  def format_date(date)
    date.strftime("%A, %B %-d")
  end

  def truncate_text(text, max)
    if !text 
      return ""
    end
    if text.length > max - 3 
      "#{text[0..max-3]}..."
    else
      text
    end
  end

  # Links to the tweet creation form on Twitter with custom tweet text
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

  # Creates a link to a Twitter account
  def link_to_twitter(handle = nil, text = "@#{handle}")
    link_to text, "https://twitter.com/#{handle}" if handle
  end

  def google_api_key
    'AIzaSyDavTubUc7sQx7cvY-NA--jLhQgOrEpgic'
  end

  # Renders the text as Markdown with autolinking enabled
  #
  # @param text [String]
  # @return [String]
  def autolink text
    renderer = RenderWithoutProtocol.new
    markdown = Redcarpet::Markdown.new(renderer, autolink: true)
    markdown.render(text)
  end

  # Renders text as Markdown
  #
  # @param text [String]
  # @return [String]
  def render_markdown text
    MarkdownRenderer.render(text)
  end

  # Finds the sponsor with the given ID
  #
  # @param sponsor_id [String]
  # @return [Array<String, Hash>] A two element array consisting of the slug
  #   and the data hash for the sponsor
  def find_sponsor sponsor_id
    # Iterates over the list of sponsors, checking each ID
    #
    # The matching data returned will be a two element array
    # where the first element is the sponsor's slug and
    # the second element is the data for the sponsor
    data.sponsors.detect {|slug, data| data.id == sponsor_id}
  end

  def talks
    data.talks.flat_map do |city, years|
      years.flat_map do |year, talks|
        talks.map do |slug, talk|
          talk.tap {|t| t[:slug] = slug}
        end
      end
    end.sort_by(&:title)
  end

  # Finds the producer entry in the sponsors (Crevalle)
  #
  # @return [Hash] The hash of data for the producing sponsor
  def producer
    # Iterates over the list of sponsors, checking whether the
    # producer flag is set
    #
    # The matching data returned will be a two element array
    # where the first element is the sponsor's slug and
    # the second element is the data for the sponsor
    data.sponsors.detect { |slug, data| data.producer }.last
  end

  # Finds the presenter with the given ID
  #
  # @param presenter_id [String]
  # @return [Array<String, Hash>] A two element array consisting of the slug
  #   and the data hash for the presenter
  def find_presenter presenter_id
    # Iterates over the list of presenters, checking each ID
    #
    # The ID in this case is actually the slug (the filename
    # without its extension).
    data.presenters.detect { |slug, data| slug == presenter_id }
  end

  # Finds the course with teh given ID
  #
  # @param course_id [String]
  # @return [Array<String, Hash>] A two element array consisting of the slug
  #   and the data hash for the course
  def find_course course_id
    # Iterates over the list of courses, checking each ID
    #
    # The ID in this case is actually the slug (the filename
    # without its extension).
    data.courses.detect { |slug, data| slug == course_id }
  end


  # Finds the location with the given ID
  #
  # @param location_id [String]
  # @return [Array<String, Hash>] A two element array consisting of the slug
  #   and the data hash for the location
  def find_location location_id
    data.locations.detect { |slug, data| slug == location_id }
  end

  # Extracts the presenters from the list of presentations
  #
  # @param presentations [Array<Hash>] An array of presentation hashes
  # @return [Array<Hash>] An array of presenter hashses, sorted by last name
  def extract_presenters presentations
    presentations.flat_map do |presentation|
      # First extract the presenters by mapping over each presentation
      # and then retrieving the presenter's info
      presentation.presenters.map{ |p| find_presenter(p) }
    end
    .uniq do |p|
      # Unique the presenters by their slug since a presenter
      # may be a part of multiple presentations
      p.first
    end
    .sort_by do |p|
      # Now sort all the presenters by their slug. Since their slug
      # should be their last name followed by their first name, this
      # should result in them being alphabetically ordered by last name
      p.first
    end
  end

  # Finds the presentation with the given ID
  def find_presentation presentation_id
    presentations = data.events.flat_map do |year, es|
      es.flat_map do |slug, event|
        event.presentations
      end
    end

    presentations.detect { |presentation| presentation && presentation.id == presentation_id }
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
