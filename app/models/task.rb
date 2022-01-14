class Task < ApplicationRecord
  validates :title, presence:true
  validates :details, presence:true
  validates :time_limit, presence: true
  enum completed: {'未着手': 0, '着手中': 1, '完了': 2}
  enum priority: {'高':0, '中': 1, '低':2}
  scope :search_title, -> (count){ where('title LIKE ?', "%#{count}%") }
  scope :search_completed, ->(count){ where(completed: "#{count}") }
  scope :time_limit, ->{all.order(time_limit: "DESC")}
  scope :created_at, ->{all.order(created_at: "DESC")}
  scope :priority, ->{all.order(priority: "ASC")}
  paginates_per 5 
end
