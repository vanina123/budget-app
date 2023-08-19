require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have a name' do
    user = User.new(name: 'Van')
    expect(user.name).to eq('Van')
  end

  it 'should validate the presence of the name' do
    user = User.new(name: nil)
    expect(user.valid?).to be false
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'should have a maximum length of 50 characters for the name' do
    user = User.new(name: 'This is a very long name that is longer than 50 characters')
    expect(user.valid?).to be false
    expect(user.errors[:name]).to include('is too long (maximum is 50 characters)')
  end
end
