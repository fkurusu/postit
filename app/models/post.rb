class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  before_save :generate_slug

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def to_param
    self.slug
  end

  def generate_slug
    self.slug = self.title.gsub(/\W/, '-').gsub(/^-/,'').gsub(/-+/, '-').downcase
  end
end
