require 'rails_helper'

describe User, 'is valid?' do
  context 'with valid email' do
    it 'should validate user' do
      user = build(:user, email: "validemail@gmail.com")
      expect(user).to be_valid
    end
  end

  context 'with unvalid email' do
    it 'shouldnt validate user' do
      user = build(:user, email: "validemailcom")
      expect(user).to_not be_valid
    end
  end
end

