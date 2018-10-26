class Idea < ApplicationRecord
  has_many :inspires, dependent: :destroy
  has_many :users, through: :inspires, dependent: :destroy
end
