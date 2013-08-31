class Comment < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :body, presence: true, length: { minimum: 10 }
end
