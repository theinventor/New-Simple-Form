class Post < ActiveRecord::Base
  attr_accessible :body, :title, :user_id, :comments_attributes
  belongs_to :user
  has_many :comments
  accepts_nested_attributes_for :comments


  validates_presence_of :user_id, :title, :body
  validate :user_is_still_valid?

  def user_is_still_valid?
    if self.user
      errors.add(:user_id, "THE API reports this user isn't valid, try again") unless user.is_email_valid?
    end
  end

end

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

