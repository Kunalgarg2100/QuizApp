class Subgenre < ApplicationRecord
	validates(:cont, presence: true,length: { maximum: 30 },uniqueness: { case_sensitive: false })
  belongs_to :genre, inverse_of: :subgenres
  has_many :questions
end
