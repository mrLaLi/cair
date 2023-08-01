FactoryBot.define do
  factory :rejection_message do
    sender_id { 1 }
    receiver_id { 1 }
    title { "MyString" }
    body { "MyText" }
  end
end
