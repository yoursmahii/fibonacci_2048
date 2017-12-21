class Game < ActiveRecord::Base
  belongs_to :user
  serialize :array_value
end
