class Expenditure < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :records, dependent: :destroy
  has_many :categories, through: :records

  validates :name, presence: true
  validates :amount, presence: true
  validates :category_ids, presence: true
end
