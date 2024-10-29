class Configuration < ApplicationRecord
    belongs_to :storage, foreign_key: 'macaddress'
    validates :macaddress,presence: true

end
