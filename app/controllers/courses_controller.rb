# 科目の画面を動かすクラス（コントローラ）
class CoursesController < ApplicationController
  # 科目一覧の画面（/courses と、トップページ）
  def index
    # 科目の表から、科目を全部取り出す。
    # 先頭に @ を付けると、画面のファイル（view）から使える。
    @courses = Course.all
  end
end
