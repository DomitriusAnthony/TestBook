class Friendship < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_friends
  validate :not_pending
  
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def create_inverse_relationship
  	friend.friendships.create(friend: user)
  end

  def destroy_inverse_relationship
  	friendship = friend.friendships.find_by(friend: user)
  	friendship.destroy if friendship
  end

  validate :not_self

  private

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end


  def not_friends
    errors.add(:friend, 'is already added') if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, 'already requested friendship') if friend.pending_friends.include?(user)
  end
end