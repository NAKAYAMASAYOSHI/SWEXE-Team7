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
    @task = Task.new(task_params.except(:grade_item_id))
    # 選ばれた項目が、この科目のものかを確かめてから使う
    @task.grade_item = @course.grade_items.find_by(id: task_params[:grade_item_id])
    if @task.save
      redirect_to course_tasks_path(@course), notice: "課題を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 編集画面：この科目の課題を1つ取り出す
  def edit
    @task = @course.tasks.find(params[:id])
  end

  # 保存ボタンを押したとき（項目は変えない）
  def update
    @task = @course.tasks.find(params[:id])
    if @task.update(task_params.except(:grade_item_id))
      redirect_to course_tasks_path(@course), notice: "課題を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  # 画面から受け取ってよい項目だけを決める
  def task_params
    params.require(:task).permit(:grade_item_id, :number, :due_on, :status, :max_score, :score)
  end
end
