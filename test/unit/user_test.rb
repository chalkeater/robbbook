require 'test_helper'

class UserTest < ActiveSupport::TestCase

	should have_many(:user_friendships)
	should have_many(:friends)
	
	test "a user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a unique profile name" do
		user = User.new
		user.profile_name = users(:robb).profile_name
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new(first_name: 'Robb', last_name: 'Schuneman', email: 'robbschuneman@gmail.com')
		user.password = user.password_confirmation = 'password'
		
		user.profile_name = "My Profile With Spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("Must be formatted correctly.")
	end
	
	test "A user must have a correctly formatted profile name" do
		user = User.new(first_name: 'Robb', last_name: 'Schuneman', email: 'robb.schuneman@gmail.com')
		user.password = user.password_confirmation = 'password'

		user.profile_name = 'boopboop_1'
		assert user.valid?
	end

	test "that no error is raised when trying to access a friend list" do
		assert_nothing_raised do
			users(:robb).friends
		end
	end

	test "that creating friendships on a user works" do
		users(:robb).friends << users(:kern)
		users(:robb).friends.reload
		assert users(:robb).friends.include?(users:kern)
		end
	end

	test "that creating a friendship based on user id and friend id works"
		UserFriendship.create user_id: users(:robb).id, friend_id: users(:kern).id
		assert users(:robb).friends.include?(users:kern)
	end
end
