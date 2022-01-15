FactoryBot.define do
  factory :task do
    title { 'テストタイトル1' }
    details { 'テスト詳細1' }
    time_limit{'2021-01-01'}
    completed{'未着手'}
    priority{'高'}
  end
  factory :second_task, class: Task do
    title { 'テストタイトル2' } 
    details { 'テスト詳細2' }
    time_limit{'2011-01-01'}
    completed{'完了'}
    priority{'低'}
  end
end
