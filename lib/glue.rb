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

    include  HTTParty

    def initialize site, user, pass
      raise  AuthError, 'Username, Password or Account is blank.' if site.empty? || user.empty? || pass.empty?
      @user               = user
      @pass               = pass
      @site               = "#{site}.#{DOMAIN}"
      self.class.base_uri   @site
    end

    def valid_site?
      Nokogiri::HTML( open("http://#{@site}")).at('body#login') ? true : false
    end
    
    def user_info
      self.class.post( USER, :query => {})    
      # RETURNS      
      #       { "rsp"     => { 
      #         "user"    => { 
      #         "author"  => "Jordan",
      #         "email"   => "jordandobson@gmail.com",
      #         "admin"   => "true" }, 
      #         "stat"    => "ok" }}
    end

    def post title, body, *opts
      self.class.post( 
        POST,
        :query  =>  {
        :title  =>  title, 
        :body   =>  body, 
        :draft  =>  opts.include?(:draft), 
        :author =>  opts.include?(:author)
      })
      
      # RETURNS
      #       { "rsp"     => {
      #         "post"    => {
      #         "title"   => "$100 Box Spring",
      #         "url"     => "http://bit.ly/pBGWf",
      #         "id"      => "12415", 
      #         "longurl" => "http://sqd.gluenow.com/feeds/1/posts/12415/" },
      #         "stat"    => "ok" }}
    end

  end

end

# For Reference This is the success responses in XML
# <rsp stat="ok">
#   <post>
#     <id>12415</id>
#     <url>http://bit.ly/pBGWf</url>
#     <longurl>http://sqd.gluenow.com/feeds/1/posts/12415/</longurl>
#     <title>$100 Box Spring</title>
#   </post>
# </rsp>
# 
# <rsp stat="ok">
#   <user>
#     <author>Jordan</author>
#     <email>jordandobson@gmail.com</email>
#     <admin>true</admin>
#   </user>
# </rsp>