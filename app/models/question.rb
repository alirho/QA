class Question < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { minimum: 10 , maximum: 150 }
  validates :body, presence: true, length: { minimum: 30 }
  # validates :user_id, presence: true
  has_many :comments, :as => "post"
end
