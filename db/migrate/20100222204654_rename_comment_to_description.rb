class RenameCommentToDescription < ActiveRecord::Migration
  def self.up
    rename_column :people, :comment, :description
  end

  def self.down
    rename_column :people, :description, :comment
  end
end
