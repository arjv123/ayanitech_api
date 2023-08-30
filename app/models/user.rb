# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  jti                    :string
#  max_tokens             :integer          default(300)
#  name                   :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("external"), not null
#  timeout                :integer          default(30)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  #============== Validations =================================

  validates :email, :password, :name, :max_tokens, :timeout, presence: true
  validates :password, length: { minimum: 8 }, confirmation: true
  validates :email, uniqueness: true
  validate :password_regex


  enum role: { internal: 0, external: 1 }


  #============== Associations =================================
  has_many :spaces, dependent: :destroy
  has_many :conversations, dependent: :destroy

  #============= Callbacks ======================================

  def generate_password_token!
    self.update_columns(reset_password_token: generate_token, reset_password_sent_at: Time.now.utc)
  end

  def password_token_valid?
   (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
   self.reset_password_token = nil
   self.password = password
   save!
  end


  private

  def generate_token
   SecureRandom.hex(10)
  end

  def password_regex
    return if password.blank? || password =~ /\A(?=.*\d)(?=.*[A-Z])(?=.*\W)[^ ]{7,}\z/

    errors.add :password, 'should include 1 uppercase letter, 1 number, 1 special character'
  end

end
