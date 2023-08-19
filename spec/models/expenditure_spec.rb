require 'rails_helper'

RSpec.describe Expenditure, type: :model do
  before :each do
    @user = User.create!(name: 'van', email: 'van@gmail.com', password: '123456', password_confirmation: '123456')
    @category = Category.new(author: @user, name: 'Vacation', icon: 'https://vacation.png')
    @expenditure = Expenditure.new(author: @user, name: 'Vacation', amount: 500)
  end

  it 'should have a name' do
    expect(@expenditure.name).to eq('Vacation')
  end

  it 'should have an amount' do
    expect(@expenditure.amount).to eq(500)
  end

  it 'should belong to an author' do
    expect(@expenditure.author).to eq(@user)
  end
end
