class User < ActiveRecord::Base

  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, :email, presence: true
  validates :password, length: { minimum: 4 }, if: :password

  def self.authenticate_with_credentials(email, password)
     return User.find_by(email: email.strip.downcase).try(:authenticate, password)
  end
end
