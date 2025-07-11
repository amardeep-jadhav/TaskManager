# app/models/task.rb
class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :priority, inclusion: { in: %w[low medium high] }
  validates :status, inclusion: { in: %w[pending in_progress completed] }

  scope :by_priority, -> { order(Arel.sql("CASE priority WHEN 'high' THEN 1 WHEN 'medium' THEN 2 WHEN 'low' THEN 3 END")) }

  def priority_badge_class
    case priority
    when "high" then "danger"
    when "medium" then "warning"
    when "low" then "success"
    end
  end

  def status_badge_class
    case status
    when "completed" then "success"
    when "in_progress" then "info"
    when "pending" then "secondary"
    end
  end
end
