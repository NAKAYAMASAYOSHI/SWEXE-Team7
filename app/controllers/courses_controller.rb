class CoursesController < ApplicationController
  # 一覧：全部の科目と、その成績の項目を取り出す
  def index
    @courses = Course.includes(:grade_items)
  end

  # 登録画面：空の科目と、空の項目の行を用意する
  def new
    @course = Course.new
    add_blank_items
  end

  # 登録ボタンを押したとき：保存できたら一覧へ、だめなら登録画面に戻す
  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path, notice: "科目を登録しました"
    else
      add_blank_items
      render :new, status: :unprocessable_entity
    end
  end

  # 削除ボタンを押したとき：その科目を消して一覧へ
  def destroy
    Course.find(params[:id]).destroy
    redirect_to courses_path, notice: "科目を削除しました"
  end

  private

  # 画面から受け取ってよい項目だけを決める（成績の項目も含む）
  def course_params
    params.require(:course).permit(:name, :pass_score, :total_classes,
                                   grade_items_attributes: [:name, :percent])
  end

  # 項目の入力行を、4行になるまで足す
  def add_blank_items
    (4 - @course.grade_items.size).times { @course.grade_items.build }
  end
end