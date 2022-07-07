class Doctor < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :profession, presence: true
  validates :price, presence: true
end
