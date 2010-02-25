class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title, :null => false
      t.text :body, :null => false
    end

    add_index :articles, :title
  end

  def self.down
    drop_table :articles
  end
end
