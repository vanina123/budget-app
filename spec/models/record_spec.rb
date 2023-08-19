require 'rails_helper'

RSpec.describe Record, type: :model do
  before :each do
    @user = User.create!(name: 'Van', email: 'van@gmail.com', password: '123456', password_confirmation: '123456')
    @category = Category.new(author: @user, name: 'Vacation', icon: 'https://vacation.png')
    @expenditure = Expenditure.new(author: @user, name: 'Vacation', amount: 500)
    @record = Record.new(category: @category, expenditure: @expenditure)
  end

  it 'should belong to a category' do
    expect(@record.category).to eq(@category)
  end

  it 'should belong to an expenditure' do
    expect(@record.expenditure).to eq(@expenditure)
  end
end
