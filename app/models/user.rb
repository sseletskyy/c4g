class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  ## Accessible attributes
  attr_accessible :password, :password_confirmation, :remember_me, :role_ids, :invitation_token,
                  :email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: true #{scope: :tenant_id}
  validates :password, length: {minimum: 6, maximum: 120}, on: :update, allow_blank: true
  validates :password, length: {minimum: 6, maximum: 120}, on: :create, allow_blank: true
end
