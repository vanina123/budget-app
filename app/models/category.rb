class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :records, dependent: :destroy
  has_many :expenditures, through: :records

  def total_amount
    expenditures.sum(:amount)
  end

  validates :name, presence: true
  validates :icon, presence: true

end
