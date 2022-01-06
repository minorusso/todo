FactoryBot.define do
  factory :task do
    title { 'test_title1' }
    details { 'test_details1' }
  end
  factory :second_task, class: Task do
    title { 'test_title2' } 
    details { 'test_details2' }
  end
end
