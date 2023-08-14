class User < ApplicationRecord
    has_many :categories, foreign_key: :author_id, dependent: destroy
    has_many :expenditures, foreign_key: :author_id, dependent: destroy

    #Validations
    validates :name, presence: true, length: { maximum: 50 }
end
