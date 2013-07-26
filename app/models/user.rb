class User < ActiveRecord::Base

  before_save { email.downcase! }
  
  has_many :rounds

  validates :name, presence: true,  length: { maximum: 50 }
  validates :password_hash, presence: true, length: { minimum: 6 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # def self.authenticate(email, password)
  #   user = find_by_email(email)
  #   p "this is user #{user}"
  #   return user if user.password == password ## this is where bcrypt overrid == so that this could return true or false against the encrypted version
  #     p "this is user inside of password boolean #{user}"
  #   nil
  # end
end
