class AddRecordingToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :recording_id, :integer
    add_column :people, :recording_type, :string
  end

  def self.down
    remove_column :peoples, :recording_type
    remove_column :peoples, :recording_id
  end
end
