class CreateAudioRecordings < ActiveRecord::Migration
  def self.up
    create_table :audio_recordings do |t|
      t.string :title
      t.text :description
      t.binary :content

      t.timestamps
    end
  end

  def self.down
    drop_table :audio_recordings
  end
end
