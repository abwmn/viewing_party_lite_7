class CreateParties < ActiveRecord::Migration[7.0]
  def change
    create_table :parties do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :movie_id
      t.string :title
      t.string :image_url
      t.integer :duration
      t.datetime :datetime

      t.timestamps
    end
  end
end
