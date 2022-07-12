class Doctor < ApplicationRecord
  validates :name, presence: true
  validates :bio, presence: true
  validates :photo, presence: true
  validates :speciality, presence: true
  validates :price, presence: true
end
