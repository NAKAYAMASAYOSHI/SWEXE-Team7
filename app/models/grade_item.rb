# 成績の項目の表（grade_items）を扱うクラス
class GradeItem < ApplicationRecord
  # 1つの項目は、必ず1つの科目に入っている（course_id が、その科目の番号）。
  belongs_to :course

  # 1つの項目は、課題をたくさん持つ。
  # 項目を消すときは、その項目の課題も一緒に消す。
  has_many :tasks, dependent: :destroy
end
