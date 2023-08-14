class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :records, dependent: :destroy
  has_many :expenditures, through: :records


  #Validations
  validates : name, presence: true, length: { maximum: 50 }
end
