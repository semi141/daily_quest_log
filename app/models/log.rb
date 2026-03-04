class Log < ApplicationRecord
  has_many :log_tags
  has_many :tags, through: :log_tags
end
