class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  def accept 
  	user.friends << friend
  	destroy
  end

  validate :not_self

  private

  def not_self
    errors.add(:frie
  end

end
