class Course < ApplicationRecord
  # 科目を消すと、その科目の「成績の項目」も一緒に消える
  has_many :grade_items, dependent: :destroy
  # 科目の課題は、成績の項目を通して取り出せる
  has_many :tasks, through: :grade_items

  # 科目の登録画面から、成績の項目もまとめて保存できるようにする
  # reject_if: :all_blank は、空の行を無視するための設定
  accepts_nested_attributes_for :grade_items, reject_if: :all_blank

  # 入力チェック：空のまま、または変な数字では登録できないようにする
  validates :name, presence: true
  validates :pass_score, numericality: { only_integer: true, in: 0..100 }
  validates :total_classes, numericality: { only_integer: true, greater_than: 0 }
  # 成績の項目があるときは、％の合計を100にする
  validate :percent_total_is_100

  private

  # 項目の割合を足して、100になっているか確かめる
  def percent_total_is_100
    items = grade_items.reject(&:marked_for_destruction?)
    return if items.empty? # 項目なしの登録は許す

    total = items.sum { |item| item.percent.to_i }
    errors.add(:base, "成績の割合は合計100%にしてください（今は#{total}%）") unless total == 100
  end
end