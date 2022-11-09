require 'rails_helper'

RSpec.describe 'User', type: :view do
  before(:each) do
    @user1 = User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Rapper from Detroit'
    )
    @user2 = User.create(
      name: 'Mabuyu',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.'
    )

    visit users_path
  end
  describe "GET '/'" do
    it 'displays the usernames' do
      expect(page).to have_content('Tom')
      expect(page).to have_content('Mabuyu')
    end
    it 'displays the photos' do
      expect(page).to have_css("img[src='#{@user1.photo}']")
    end
    it 'displays the number of posts per user' do
      expect(page).to have_content("Number of Posts: #{@user1.postscounter}")
    end
    it 'displays the correct link to the user show page' do
      expect(page).to have_link(href: user_path(@user1))
    end
  end
end
