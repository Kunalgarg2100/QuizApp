class Genre < ApplicationRecord
	validates(:content, presence: true,length: { maximum: 15 },uniqueness: { case_sensitive: false })
	has_many :subgenres,  inverse_of: :genre , dependent: :destroy
	accepts_nested_attributes_for :subgenres, reject_if: proc { |attributes| attributes['cont'].blank? }, allow_destroy: true

end
