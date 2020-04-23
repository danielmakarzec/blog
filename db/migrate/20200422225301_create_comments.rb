class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.string :edit_history, default: ''
      t.boolean :reply, default: false
      t.string :comment_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
