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
  include AuthHelper
  attr_accessible :email, :name, :password, :password_confirmation
  attr_accessor :current_place
  include Gravtastic
  gravtastic
  has_secure_password
  require 'set'

  has_many :bets, dependent: :destroy
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A\w+\.\w+@sollers\.pl\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def current_score
    valid_bets.map{|a| a.points_awarded.nil? ? 0 : a.points_awarded}.sum
  end
  
  def available_score
    finalBets = valid_bets.select { |bet| not bet.match.result.nil? }
    finalBets.map{|bet| bet.match.is_playoff ? 3 : 2}.sum
  end
  
  def available_bets_count
    finalBets = valid_bets.select { |bet| not bet.match.result.nil? }
    finalBets.count
  end
  
  def current_score_percent_total
    100 * current_score / 144
  end
  
  def current_score_percent_available
    if available_score > 0
      100 * current_score / available_score
    else
      0
    end
  end
  
  def available_score_percent_total
    100 * available_score / 144
  end
  
  def password_reset
    @new_password = set_random_password()
    UserMailer.reset_password_email(self, @new_password).deliver
  end
  
  def valid_bets
    @valid_bets = Array.new
    @used_matches = Set.new
    bets.sort{ |a,b| b[:updated_at] <=> a[:updated_at] }.each do |bet|
      if not @used_matches.include? bet.match.id
        @valid_bets.push bet
        @used_matches.add bet.match.id
      end
    end
    @valid_bets
  end

private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
  
  def set_random_password
    @new_password = self.generate_random_password()
    self.password = @new_password
    self.password_confirmation = @new_password
    if self.save
      @new_password
    else
      self.errors.full_messages.each do |err|
        puts err
      end
      raise "There were errors! (See logs above.)"
    end
  end
  
end
