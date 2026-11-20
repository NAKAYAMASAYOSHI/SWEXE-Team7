class CoursesController < ApplicationController
  # 一覧：全部の科目を取り出す
  def index
    @courses = Course.all
  end

  # 登録画面：空の科目を用意する
  def new
    @course = Course.new
  end

  # 登録ボタンを押したとき：保存できたら一覧へ、だめなら登録画面に戻す
  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path, notice: "科目を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 削除ボタンを押したとき：その科目を消して一覧へ
  def destroy
    Course.find(params[:id]).destroy
    redirect_to courses_path, notice: "科目を削除しました"
  end

  private

  # 画面から受け取ってよい項目だけを決める（それ以外は無視する）
  def course_params
    params.require(:course).permit(:name, :pass_score, :total_classes)
  end
end
