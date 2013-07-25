class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :question, dependent: :destroy
end
