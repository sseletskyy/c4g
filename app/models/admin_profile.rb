class AdminProfile < ActiveRecord::Base
  belongs_to :admin

  attr_accessible :first_name, :middle_name, :last_name, :phone

  validates :first_name, :middle_name, :last_name, :phone,
            presence: {message: I18n.t("errors.messages.blank")}
end
