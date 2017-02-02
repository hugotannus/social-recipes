class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :kind
  belongs_to :user

  enum difficulty: ['fácil', 'moderada', 'difícil']
  mount_uploader :picture, PictureUploader

  def include?(term)
    title.downcase.include?(term.downcase)
  end
end
