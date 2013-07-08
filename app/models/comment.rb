class Comment < ActiveRecord::Base
  belongs_to :question
end
