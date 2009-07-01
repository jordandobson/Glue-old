require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'open-uri'

module Glue

  VERSION = '0.0.1'

  class AuthError < StandardError; end

  class Client

    DOMAIN = 'gluenow.com'
    POST   = '/api/post'
    USER   = '/api/user'
    NEWS   = '/news/rss'

    include  HTTParty
    format  :xml

    def initialize site, user, pass
      raise  AuthError, 'Username, Password or Account is blank.' \
        if site.empty? || user.empty? || pass.empty?
      @auth   = { :username => user, :password => pass }
      @site   = "#{site}.#{DOMAIN}"
      self.class.base_uri @site
    end

    def valid_site?
      Nokogiri::HTML(open( "http://#{@site}" )).at( 'body#login' ) ? true : false
    end

    def user_info
      self.class.post( USER, :query => {}, :basic_auth => @auth)
    end

    def post title, body, *opts
      self.class.post(
        POST,
        :query      =>  {
        :title      =>  title,
        :body       =>  body,
        :draft      =>  opts.include?( :draft  ),
        :author     =>  opts.include?( :author )},
        :basic_auth =>  @auth
      )
    end

  end

end