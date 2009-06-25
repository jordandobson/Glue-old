require "test/unit"
require "glue"

class TestGlue < Test::Unit::TestCase

  # TO DO
  # - Stub Network Tests
  # - Test user_info method
  # - Test post method

  def setup
    @a      = 'sqd'
    @u      = 'username'
    @p      = 'password'
    @c      = Glue::Client.new( @a, @u, @p )
    @title  = "My Title"
    @body   = "Body Text"
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
    actual    = Glue::Client.new( @a, @u, @p ).valid_site?
    expected  = true
    assert_equal expected, actual
  end

  def test_site_is_invalid
    actual    = Glue::Client.new( "x", @u, @p ).valid_site?
    expected  = false
    assert_equal expected, actual
  end
  
  def test_site_is_invalid
    actual    = Glue::Client.new( "x", @u, @p ).valid_site?
    expected  = false
    assert_equal expected, actual
  end
  
#   def test_options_are_accepted
#     expected = [:author, :draft]
#     assert_equal expected, @c.post(@title, @body, :author, :draft)
#   end

end