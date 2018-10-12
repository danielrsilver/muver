class Proposal < ApplicationRecord

  after_save :create_notification

  belongs_to :user
  belongs_to :listing
  has_one :notification

  def create_notification
    notification = Notification.new(message:"#{Proposal.last.user.first_name} wants to help you move!")
    notification.proposal = Proposal.last
    notification.user = Proposal.last.listing.user
    notification.save!
  end

end
