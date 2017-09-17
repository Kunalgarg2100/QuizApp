class Leaderboard < ApplicationRecord
  belongs_to :user
  belongs_to :subgenre
  default_scope -> { order(score: :desc) }

end
