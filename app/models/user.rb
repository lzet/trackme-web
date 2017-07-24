class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         #:recoverable,
         :rememberable, :trackable, :validatable
  validates :login, presence: true, length: {minimum: 4}
  has_many :trackpoints, dependent: :destroy
  def email_required?
    false
  end

  def email_changed?
    false
  end  
end
