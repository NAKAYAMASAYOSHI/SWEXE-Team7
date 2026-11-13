class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :pass_score
      t.integer :total_classes
      t.integer :absences, default: 0, null: false

      t.timestamps
    end
  end
end
