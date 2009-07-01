require "test/unit"
require "glue"
require "mocha"
require "fakeweb"

# Makes sure this doesn't hit the network
FakeWeb.allow_net_connect = false

class TestGlue < Test::Unit::TestCase

  def setup
    @a          = 'AccountSubDomain'
    @u          = 'Username'
    @p          = 'Password'
    @c          = Glue::Client.new( @a, @u, @p )
    @title      = "My Title"
    @body       = "Body Text"
    @url        = "http://bit.ly/sakIM"
    @id         = "14415"
    @lurl       = "http://jordandobson.com"
    @resp_fail  = {}
    
    @resp_ok    = { "rsp"     => {
                    "user"    => {
                    "author"  => "Jordan",
                    "admin"   => "true"  ,
                    "email"   => nil    },
                    "stat"    => "ok"   }}
                    
    @post_ok    = { "rsp"     => {
                    "post"    => {
                    "title"   => @title , 
                    "url"     => @url   , 
                    "id"      => @id    , 
                    "longurl" => @lurl  },
                    "stat"    => "ok"   }}

  end

  def test_raises_without_account_url
    assert_raise Glue::AuthError do
      Glue::Client.new( '', @u, @p )
    end
  end

  def test_raises_without_user
    assert_raise Glue::AuthError do
      Glue::Client.new( @a, '', @p )
    end
  end

  def test_raises_without_password
    assert_raise Glue::AuthError do
      Glue::Client.new( @a, @u, '' )
    end
  end

  def test_raises_with_number_account_url
    assert_raise NoMethodError do
      Glue::Client.new( 00, @u, @p )
    end
  end

  def test_raises_with_number_user
    assert_raise NoMethodError do
      Glue::Client.new( @a, 00, @p )
    end
  end

  def test_raises_with_number_password
    assert_raise NoMethodError do
      Glue::Client.new( @a, @u, 00 )
    end
  end

  def test_site_is_valid
    OpenURI.stubs(:open_uri).returns('<body id="login"></body>')
    assert @c.valid_site?
  end

  def test_site_is_invalid
    OpenURI.stubs(:open_uri).returns('<body></body>')
    assert   !@c.valid_site?
  end

  def test_user_info_valid
    Glue::Client.stubs(:post).returns(@resp_ok)
    actual       = @c.user_info
    assert_equal   "ok",     actual["rsp"]["stat"]
    assert                   actual["rsp"]["user"]
    assert_equal   "Jordan", actual["rsp"]["user"]["author"]
    assert_equal   "true",   actual["rsp"]["user"]["admin"]
    assert_equal   nil,      actual["rsp"]["user"]["email"]
  end

  def test_user_info_invalid
    Glue::Client.stubs(:post).returns(@resp_fail)
    actual       = @c.user_info
    assert_equal   @resp_fail, actual
  end

  def test_bad_post_response
    Glue::Client.stubs(:post).returns(@resp_fail)
    actual       = @c.post(@title, @body)
    assert_equal   @resp_fail, actual
  end

  def test_good_post_response
    Glue::Client.stubs(:post).returns(@post_ok)
    actual       = @c.post(@title, @body)
    assert_equal   "ok",     actual["rsp"]["stat"]
    assert                   actual["rsp"]["post"]
    assert_equal   @title,   actual["rsp"]["post"]["title"]
    assert_equal   @url,     actual["rsp"]["post"]["url"]
    assert_equal   @id,      actual["rsp"]["post"]["id"]
    assert_equal   @lurl,    actual["rsp"]["post"]["longurl"]
  end

end