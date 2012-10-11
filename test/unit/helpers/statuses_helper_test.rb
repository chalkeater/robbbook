require 'test_helper'

class StatusesHelperTest < ActionView::TestCase
	test "that a status requires content" do 
		status = Status.new
		assert !status.save
		assert !status.errors[:content].empty
	end
end
