FactoryBot.define do
  factory :task do
    title { 'test_title' }
    details { 'test_details' }
  end
  factory :second_task, class: Task do
    title { 'test_title' } 
    details { '' }
  end
end
