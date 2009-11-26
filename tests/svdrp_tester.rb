#
# Unit tests for svdrp
#

require 'rubygems'
require 'lib/svdrp.rb'
require 'test/unit'

class SVDRPTester < Test::Unit::TestCase

	def setup
		@svdrp = SVDRP.new 'nvdr', '2001'
	end

	def teardown
		@svdrp.disconnect
	end

	def test_connect
		ret = @svdrp.connect
		assert_match /220/, ret
	end

	def test_connected?
 		@svdrp.connect
        assert(@svdrp.connected?)
	end

	def test_disconnect
		@svdrp.connect
		assert @svdrp.connected?

		@svdrp.disconnect
		assert !@svdrp.connected?

		@svdrp.disconnect
		assert !@svdrp.connected?

		bad = SVDRP.new 'diipadaapa'
		bad.disconnect
		assert !bad.connected?
	end

	def test_channel
		@svdrp.connect

		ret = @svdrp.channel
		assert_match /250 /, ret

		@svdrp.channel = 1
		ret = @svdrp.channel
		assert_match /250 1/, ret

		@svdrp.disconnect
	end
end
