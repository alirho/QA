class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :question_id
      t.integer :user_id
      t.references :question

      t.timestamps
    end
  end
end
