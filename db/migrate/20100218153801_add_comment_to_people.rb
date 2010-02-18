class AddCommentToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :comment, :text
  end

  def self.down
    remove_column :people, :comment
  end
end
