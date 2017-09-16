class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.references :user, foreign_key: true
      t.references :subgenre, foreign_key: true
      t.integer :qno
      t.integer :score

      t.timestamps
    end
  end
end
