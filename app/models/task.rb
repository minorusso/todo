class Task < ApplicationRecord
  belongs_to :user 
  validates :title, presence:true
  validates :details, presence:true
  validates :time_limit, presence: true
  enum completed: {'選択して下さい':0, '未着手':1, '着手中':2, '完了':3}
  enum priority: {'選択してください':0 ,'高':1, '中':2, '低':3}
  scope :search_title, -> (count){ where('title LIKE ?', "%#{count}%") }
  scope :search_completed, ->(count){ where(completed: "#{count}") }
  scope :time_limit, ->{all.order(time_limit: "DESC")}
  scope :created_at, ->{all.order(created_at: "DESC")}
  scope :priority, ->{all.order(priority: "ASC")}
  paginates_per 5 
end
