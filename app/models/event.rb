class Event < ActiveRecord::Base
attr_accessible :name, :description, :start_time, :end_time, :location, :street, :city
has_many :users

belongs_to  :user  # the creator

validates_presence_of :start_time, :end_time, :name

end
