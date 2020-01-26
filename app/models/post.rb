class Post < ApplicationRecord

	validates :title, presence: true, length: { maximum: 20 }
	validates :body, presence: true, length: { maximum: 2500 }

	attachment :post_image

	belongs_to :user
	belongs_to :genre
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def Post.search(search)
			Post.where(["title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%"])
	end

	def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
  end
end