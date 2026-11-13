# このアプリの「URL」と「画面」の対応表
Rails.application.routes.draw do
  # 動いているか確かめるための入口。Railsが最初から用意している。消さない。
  get "up" => "rails/health#show", as: :rails_health_check

  # トップページ（/）を開いたら、科目一覧（CoursesControllerのindex）を出す。
  root "courses#index"

  # 科目の一覧・登録・編集・削除のURLを、まとめて作る（/courses など）。
  # 1件だけ見る画面（show）は使わないので、除く。
  resources :courses, except: [ :show ] do
    # 科目の中に、課題のURLを入れる（/courses/科目の番号/tasks など）。
    resources :tasks, except: [ :show ]
  end
end
