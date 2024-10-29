class Storage < ApplicationRecord
    self.primary_key = 'macaddress'
    validates :macaddress, uniqueness: true,presence: true
    has_many :configurations, foreign_key: 'macaddress'
end