class Post < ApplicationRecord

	validates :title, presence: true, length: { maximum: 30 }
	validates :body, presence: true, length: { maximum: 200 }

	attachment :post_image

	belongs_to :user
	belongs_to :genre
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
        end
end
