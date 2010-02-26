class VideoRecording < ActiveRecord::Base
  has_many :people, :as => :recording
end
