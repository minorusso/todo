FactoryBot.define do
  factory :task do
    title { 'test_title1' }
    details { 'test_details1' }
    time_limit{'2026-01-01'}
  end
  factory :second_task, class: Task do
    title { 'test_title2' } 
    details { 'test_details2' }
    time_limit{'2026-01-01'}
  end
end
