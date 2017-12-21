class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :user, index: true
      t.integer :score
      t.integer :grid

      t.timestamps
    end
  end
end
