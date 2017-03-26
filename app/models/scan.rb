class Scan < ActiveRecord::Base
  enum status: [:queued, :running, :finished]
  validates :title, presence: true
  validates :target, presence: true
end
