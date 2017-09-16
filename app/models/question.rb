class Question < ApplicationRecord
  belongs_to :subgenre
  attribute :country
	validates(:ques, presence: true)
	validates :optA, presence: true
	validates :optB, presence: true
	validates :optC, presence: true
	validates :optD, presence: true
	validates :correctopt, presence: true

end
