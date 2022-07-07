class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :photo
      t.string :bio
      t.string :profession
      t.integer :price

      t.timestamps
    end
  end
end
