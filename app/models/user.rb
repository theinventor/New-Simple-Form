class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :accepted_terms, :send_password_to
  attr_accessor :password, :password_confirmation, :send_password_to

  has_many :posts
  has_many :comments

  validates_presence_of :email, :name
  validates_acceptance_of :accepted_terms

  validate :passwords_match_if_set
  validate :make_sure_email_is_available_via_api
  validate :notify_to_email_is_an_email

  def passwords_match_if_set
    if self.password
      errors.add(:password, "Passwords must match") unless self.password == self.password_confirmation
    end
  end

  def make_sure_email_is_available_via_api
    errors.add(:email, "API says that email is not valid, try again") unless is_email_valid?
  end

  def is_email_valid?
    # this is just a pretend API that will throw errors now and then
    sleep 2
    if rand(3) == 1  #we must have got an email problem from our API! OH NOE
      puts "It's not valid"
      false
    else
      puts "It's TOTALLY valid"
      true
    end
  end

  def notify_to_email_is_an_email
    errors.add(:send_password_to, "is not valid") if self.send_password_to and self.send_password_to.length > 0 unless self.send_password_to =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  end

end

# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :string(255)
#  password_hash :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

