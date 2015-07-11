class CreateRedditComments < ActiveRecord::Migration
  def change
    create_table :reddit_comments do |t|
      t.text :comment_text
      t.integer :sentiment

      t.timestamps
    end
  end
end
