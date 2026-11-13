# 科目の表（courses）を扱うクラス
class Course < ApplicationRecord
  # 1つの科目は、成績の項目（課題30％、小テスト20％など）をたくさん持つ。
  # dependent: :destroy は、「科目を消すとき、その科目の項目も一緒に消す」という意味。
  has_many :grade_items, dependent: :destroy

  # 科目の課題は、項目を通して取り出せる。
  # course.tasks と書くと、その科目の課題が全部取れる。
  has_many :tasks, through: :grade_items
end
