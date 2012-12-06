class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  attr_accessible :body, :post_id, :user_id

  validate :no_swear_words

  def no_swear_words
    bad_words = %w"poop fart damn javier"
    bad_words.each do |word|
      errors.add(:body, "You can't use those naughty words") if self.body.include? word
    end
  end

end
