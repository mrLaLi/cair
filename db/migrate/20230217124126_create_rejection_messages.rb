class CreateRejectionMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :rejection_messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
