class Person < ActiveRecord::Base
  validates_presence_of :name, :address

  attr_accessible :name, :address, :phone
  
  has_many :comments
end
