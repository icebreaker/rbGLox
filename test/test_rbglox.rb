require 'rubygems'
require 'test/unit'
require 'rbglox'

class RBGLoxTest < Test::Unit::TestCase
  def test_version
    assert_equal RBGLox::VERSION, '0.1.0'
  end
end
