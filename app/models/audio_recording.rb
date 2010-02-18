class AudioRecording < ActiveRecord::Base
  has_many :people, :as => :recording
end
