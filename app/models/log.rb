class Log < ApplicationRecord
  has_many :log_tags, dependent: :destroy
  has_many :tags, through: :log_tags

  attr_accessor :tag_names
  
end
