require 'rails_helper'

RSpec.describe 'User', type: :view do
  before(:each) do
    @user = User.create(
        name: 'Tom',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Rapper from Detroit'
    )
    
    4.times do
     @post = Post.create(author: @user, title: 'Hello', text: 'This is one of the first posts')
    end
    Post.create(author: @user, title: 'Hello', text: 'This is the fourth post')

    visit user_path(@user)
  end
  describe "GET '/'" do
    it 'displays the usernames' do
      expect(page).to have_content('Tom')
    end
    it 'displays the photos' do
      expect(page).to have_css("img[src='#{@user.photo}']")
    end
    it 'displays the number of posts per user' do
      expect(page).to have_content("Number of Posts: #{@user.postscounter}")
    end
    it 'displays the user\'s bio' do
      expect(page).to have_content('Rapper from Detroit')
    end
    it 'displays only the 3 most recent posts' do
      expect(page).to have_content('This is one of the first posts')
    end
    it 'displays a link to all the user\'s posts' do
      expect(page).to have_link('See all posts')
    end
    it 'displays a link to all the user\'s posts' do
      expect(page).to have_link('See all posts')
    end
    it 'redirects the user to the right post' do
        expect(page).to have_link("Post ##{@post.id}", href: user_post_path(@user, @post))
    end
    it 'displays directs the user to the user\'s post\'s index page' do
      expect(page).to have_link('See all posts', href: user_posts_path(@user))
    end
 end
end
