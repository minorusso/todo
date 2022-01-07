class Task < ApplicationRecord
  validates :title, presence:true
  validates :details, presence:true
  validates :time_limit, presence: true
  enum completed: {'未着手': 0, '着手中': 1, '完了': 2}
end
