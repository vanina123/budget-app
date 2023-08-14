class Expenditure < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :records, dependent: :destroy
  has_many :categories, through: :records

  validates :name, presence: true, length: { maximum: 50 }
  validates :amount, presence: true, numeracity: { greater_than: 0 }
end
