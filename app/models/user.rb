class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source
  before_save { self.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX =   /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
                          uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }
  
  def voted_for?(question)
    evaluations.where(target_type: question.class, target_id: question.id).present?
  end
  
   private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
