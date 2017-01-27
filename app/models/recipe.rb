class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :kind
end
