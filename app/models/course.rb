class Course < ApplicationRecord
  # 科目を消すと、その科目の「成績の項目」も一緒に消える
  has_many :grade_items, dependent: :destroy
  # 科目の課題は、成績の項目を通して取り出せる
  has_many :tasks, through: :grade_items

  # 入力チェック：空のまま、または変な数字では登録できないようにする
  validates :name, presence: true
  validates :pass_score, numericality: { only_integer: true, in: 0..100 }
  validates :total_classes, numericality: { only_integer: true, greater_than: 0 }
end
