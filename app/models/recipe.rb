class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :kind

  enum difficulty: ['fácil', 'moderada', 'difícil']
end
