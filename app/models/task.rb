class Task < ApplicationRecord
  # 選べる状態の一覧
  STATUSES = %w[未着手 進行中 提出済み 返却済み].freeze

  belongs_to :grade_item
  has_one :course, through: :grade_item

  # 入力チェック
  validates :number, numericality: { only_integer: true, greater_than: 0 }
  validates :due_on, presence: true
  validates :status, inclusion: { in: STATUSES }
  # 返却済みのときだけ、得点を必須にする
  validates :score, presence: true, if: -> { status == "返却済み" }

  # 提出済み・返却済みなら「終わっている」
  def done?
    %w[提出済み 返却済み].include?(status)
  end

  # 締切を過ぎていて、終わっていなければ「期限切れ」
  def overdue?
    due_on.present? && due_on < Date.current && !done?
  end
end
