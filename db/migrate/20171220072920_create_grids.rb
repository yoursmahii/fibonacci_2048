class CreateGrids < ActiveRecord::Migration
  def change
    create_table :grids do |t|
      t.integer :size

      t.timestamps
    end
  end
end
