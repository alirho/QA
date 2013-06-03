class Question < ActiveRecord::Base
  has_many :answers
  has_many :taggings
  has_many :tags, through: :taggings
  has_one :visit, :as => :visitable
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { minimum: 10 , maximum: 150 }
  validates :body, presence: true, length: { minimum: 30 }
  validates :user_id, presence: true
  has_many :comments, :as => "post"
  has_reputation :votes, source: :user, aggregated_by: :sum
  
  
  def self.tagged_with(name)
    Tag.find_by_name!(name).questions
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
