class AddDefaultValueForFinished < ActiveRecord::Migration
  def change
  	change_column :games, :finished, :boolean, :default => false
  end
end
