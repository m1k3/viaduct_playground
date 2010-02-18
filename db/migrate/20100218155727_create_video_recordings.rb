class CreateVideoRecordings < ActiveRecord::Migration
  def self.up
    create_table :video_recordings do |t|
      t.string :title
      t.text :description
      t.binary :content

      t.timestamps
    end
  end

  def self.down
    drop_table :video_recordings
  end
end
