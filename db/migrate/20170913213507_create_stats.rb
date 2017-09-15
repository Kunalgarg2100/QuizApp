class CreateStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
