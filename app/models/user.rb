class User < ActiveRecord::Base
  has_many :authentications
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source
  before_save { self.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { minimum: 3 , maximum: 20 },
                uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX =   /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
                uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, :allow_blank => true
  validates :password_confirmation, presence: true, :allow_blank => true

  
  def send_password_reset
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def voted_for?(question)
    evaluations.where(target_type: question.class, target_id: question.id).present?
  end
  
  def voted_for?(answer)
    evaluations.where(target_type: answer.class, target_id: answer.id).present?
  end
  
   private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
