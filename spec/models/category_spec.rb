require 'rails_helper'

RSpec.describe Category, type: :model do
  before :each do
    @user = User.create!(name: 'Van', email: 'van@gmail.com', password: '123456', password_confirmation: '123456')
    @category = Category.new(author: @user, name: 'Vacation', icon: 'https://vacation.png')
  end

  it 'should be valid' do
    expect(@category).to be_valid
  end

  it 'is not valid without an author' do
    @category.author = nil
    expect(@category).to_not be_valid
  end

  it 'is not valid without a name' do
    @category.name = nil
    expect(@category).to_not be_valid
  end

  it 'is not valid without an icon' do
    @category.icon = nil
    expect(@category).to_not be_valid
  end
end
