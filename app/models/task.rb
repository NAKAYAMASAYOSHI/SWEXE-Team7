# 課題の表（tasks）を扱うクラス
class Task < ApplicationRecord
  # 1つの課題は、必ず1つの項目に入っている（grade_item_id が、その項目の番号）。
  belongs_to :grade_item

  # 課題の科目は、項目を通して取り出せる。
  # task.course と書くと、その課題の科目が取れる。
  has_one :course, through: :grade_item
end
