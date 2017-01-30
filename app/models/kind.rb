class Kind < ApplicationRecord
  has_many :recipes

  before_save { self.name = name.downcase }
  validates :name, presence: true, uniqueness: true
end
