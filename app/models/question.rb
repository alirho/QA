class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :taggings
  has_many :comments, dependent: :destroy
  has_many :tags, through: :taggings
  has_one :visit, :as => :visitable
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { minimum: 10 , maximum: 200 }
  validates :body, presence: true, length: { minimum: 30 }
  validates :user_id, presence: true
  validates :tags, presence: true
  has_reputation :votes, source: :user, aggregated_by: :sum

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by_name(name) }
    self.tags = new_or_found_tags
  end

  
  
  def self.search(search)
    if search
      find(:all, :conditions => ['body LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

end
