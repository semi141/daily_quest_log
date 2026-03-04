class Tag < ApplicationRecord
  has_many :log_tags
  has_many :logs, through: :log_tags
end
