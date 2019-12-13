
require 'toto'
require 'rack/contrib'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  #
    set :author,    'NBK'                               # blog author
    set :title,     'blog.nbk.dev'                   # site title
  # set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  # set :markdown,  :smart                                    # use markdown + smart-mode
    set :commento,  true                             # commento comment system
  # set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  # set :ext,       'txt'                                     # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds

  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end

# Security Headers
use Rack::ResponseHeaders do |headers|
      headers['Content-Security-Policy'] = "default-src 'self' https://commento.io https://fonts.gstatic.com https://gist.github.com https://cdn.commento.io/js/commento.js https://commento.io/api/comment/list https://cdn.commento.io/css/commento.css; img-src 'self' data: https://stackexchange.com/users/flair/187709.png; style-src 'self' 'unsafe-inline' https://cdn.commento.io/css/commento.css https://github.githubassets.com https://fonts.googleapis.com/css"
      headers['X-Frame-Options'] = "DENY"
      headers['X-XSS-Protection'] = "1; mode=block"
      headers['Referrer-Policy'] = "same-origin"
end

run toto

