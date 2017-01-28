class Kind < ApplicationRecord
  before_save { self.name = name.downcase }
  validates :name, presence: true, uniqueness: true
end
