class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :story
      t.text :impression
      
      t.timestamps
    end
  end
end
