class State < ApplicationRecord
  belongs_to :user
  belongs_to :subgenre
end
