class CreateAnimes < ActiveRecord::Migration[5.2]
  def change
    create_table :animes do |t|
      t.string :name
      t.text :description
      t.integer :release_year, limit: 4
      t.string :author
      t.integer :number_eps
      t.string :still_casting, limit: 3

      t.timestamps
    end
  end
end
