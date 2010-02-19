class Person < ActiveRecord::Base
  attr_accessible :name, :address, :phone
  
  #belongs_to :recording, :polymorphic => true
  
  has_many :comments
end
