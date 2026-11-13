class CreateGradeItems < ActiveRecord::Migration[8.1]
  def change
    create_table :grade_items do |t|
      t.references :course, null: false, foreign_key: true
      t.string :name
      t.integer :percent

      t.timestamps
    end
  end
end
