class RejectionMessage < ApplicationRecord
  belongs_to :sender,   class_name: "User", inverse_of: :rejection_messages_sent
  belongs_to :receiver, class_name: "User", inverse_of: :rejection_messages_received

  validates :title,    presence: true
  validates :body,     presence: true
  validates :sender,   presence: true
  validates :receiver, presence: true

end
