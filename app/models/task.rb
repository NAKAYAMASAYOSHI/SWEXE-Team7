class Task < ApplicationRecord
  # 選べる状態の一覧
  STATUSES = %w[未着手 進行中 提出済み 返却済み].freeze

  belongs_to :grade_item
  has_one :course, through: :grade_item

  # 入力チェック
  validates :number, numericality: { only_integer: true, greater_than: 0 }
  validates :due_on, presence: true
  validates :status, inclusion: { in: STATUSES }
  # 満点と得点は、なくてもよい。あるときは整数で、得点は0以上にする
  validates :max_score, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  # 返却済みのときだけ、得点を必須にする
  validates :score, presence: true, if: -> { status == "返却済み" }
  # 得点が満点を超えていないか確かめる
  validate :score_not_over_max

  # 提出済み・返却済みなら「終わっている」
  def done?
    %w[提出済み 返却済み].include?(status)
  end

  # 締切を過ぎていて、終わっていなければ「期限切れ」
  def overdue?
    due_on.present? && due_on < Date.current && !done?
  end

  private

  def score_not_over_max
    return if score.nil? || max_score.nil?

    errors.add(:score, "は満点（#{max_score}）以下にしてください") if score > max_score
  end
end
