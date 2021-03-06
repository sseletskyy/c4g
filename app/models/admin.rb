class Admin < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  ## Accessible attributes
  attr_accessible :password, :password_confirmation, :remember_me, :role_ids, :invitation_token,
                  :email

  has_one :admin_profile, dependent: :destroy
  accepts_nested_attributes_for :admin_profile

  CUSTOM_VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: User::CUSTOM_VALID_EMAIL_REGEX}, uniqueness: true #{scope: :tenant_id}
  validates :password, length: {minimum: 6, maximum: 120}, on: :update, allow_blank: true
  validates :password, length: {minimum: 6, maximum: 120}, on: :create, allow_blank: true

  #validates :role_ids, presence: true, on: :create

  # fetch users by a specific role (and resource)
  def self.by_role(role, resource = nil)
    admins = joins(:roles).where({:roles => {:name => role}})
    if resource
      if resource.is_a? Class
        admins = admins.where({:roles => {:resource_type => resource.name, :resource_id => nil}})
      else
        admins = admins.where({:roles => {:resource_type => resource.class.name, :resource_id => resource.id}})
      end
    end
  end

end
