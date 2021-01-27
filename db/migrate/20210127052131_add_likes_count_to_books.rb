class AddLikesCountToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :likes_count, :integer
  end
end
