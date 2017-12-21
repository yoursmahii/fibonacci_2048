class AddFreeSizeAndArrayValueToGames < ActiveRecord::Migration
  def change
    add_column :games, :free_size, :integer, :default => 0
    add_column :games, :array_value, :text
  end
end
