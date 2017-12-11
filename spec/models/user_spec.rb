# RSpec.describe User, :type => :model do
#   subject { User.new }

#   it "is valid with valid attributes" do
#     subject.email = "myemail@gmail.com"
#     subject.password = "some_passw"
#     expect(subject).to be_valid
#   end

#   it "is not valid with invalid email" do
#     expect(subject).to_not be_valid
#   end

#   it "is not valid without a description"
#   it "is not valid without a start_date"
#   it "is not valid without a end_date"
# end

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

