class TasksController < ApplicationController
  # どの科目の課題かを、全部の処理の前に調べる
  before_action :set_course

  # 一覧：この科目の課題を、締切が近い順に並べる
  def index
    @tasks = @course.tasks.includes(:grade_item).order(:due_on)
  end

  # 登録画面：状態は「未着手」から始める
  def new
    @task = Task.new(status: "未着手")
  end

  # 登録ボタンを押したとき
  def create
    # 成績の項目の画面は第11回で作る。それまでは「課題」という項目を自動で1つ用意して使う
    grade_item = @course.grade_items.first_or_create!(name: "課題", percent: 0)
    @task = grade_item.tasks.new(task_params)
    if @task.save
      redirect_to course_tasks_path(@course), notice: "課題を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  # 画面から受け取ってよい項目だけを決める
  def task_params
    params.require(:task).permit(:number, :due_on, :status, :max_score, :score)
  end
end
