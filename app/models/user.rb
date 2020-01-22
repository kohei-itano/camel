class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 100 }

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

	# 自分がフォロしているユーザーとの関連
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
	has_many :followings, through: :active_relationships, source: :follower
	# 自分がフォローされるユーザーとの関連
	has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
	has_many :followers, through: :passive_relationships, source: :following

	def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

end
