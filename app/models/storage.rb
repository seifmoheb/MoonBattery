class Storage < ApplicationRecord
    validates :macaddress, uniqueness: true
end
