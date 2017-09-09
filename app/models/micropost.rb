class Micropost < ApplicationRecord
	belongs_to :user #user must exit
	validates :content, length: { maximum: 140 } ,presence: true #conetent should be present
end
