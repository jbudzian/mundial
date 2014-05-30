# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_accessor :current_place
  include Gravtastic
  gravtastic
  has_secure_password

  has_many :bets, dependent: :destroy
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A\w+\.\w+@sollers\.pl\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def current_score
    bets.map{|a| a.points_awarded.nil? ? 0 : a.points_awarded}.sum
  end
  
  def available_score
    Result.all.map{|r| r.match.is_playoff ? 3 : 2}.sum
  end
  
  def current_score_percent_total
    100 * current_score / 144
  end
  
  def current_score_percent_available
    100 * (available_score - current_score) / 144
  end
  
private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
