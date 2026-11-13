class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :grade_item, null: false, foreign_key: true
      t.integer :number
      t.date :due_on
      t.string :status
      t.integer :max_score
      t.integer :score

      t.timestamps
    end
  end
end
