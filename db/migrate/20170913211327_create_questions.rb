class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :ques
      t.string :optA
      t.string :optB
      t.string :optC
      t.string :optD
      t.string :correctopt
      t.references :subgenre, foreign_key: true

      t.timestamps
    end
  end
end
