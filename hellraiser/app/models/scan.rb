class Scan < ActiveRecord::Base
	validates :title, presence: true
	validates :target, presence: true
end
