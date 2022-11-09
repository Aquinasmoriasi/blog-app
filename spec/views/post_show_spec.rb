require 'rails_helper'

RSpec.describe 'Post/show', type: :view do
  before(:each) do
    @user = User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Rapper from Detroit'
    )
    @post = Post.create(author: @user, title: 'Hello', text: 'This is one of the first posts')
    @comment = Comment.create(text: 'this is the sixth comment!', author: @user, post: @post)
    5.times do
      Comment.create(text: 'this is among the first comments!', author: @user, post: @post)
    end
    Like.create! author: @user, post: @post

    visit "users/#{@user.id}/posts"
  end
  describe "GET '/user/:id/posts'" do
    it 'displays the username' do
      expect(page).to have_content('Tom')
    end
    it 'displays the user\'s profile photo' do
      expect(page).to have_css("img[src='#{@user.photo}']")
    end
    it 'displays the number of posts per user' do
      expect(page).to have_content("Number of Posts: #{@user.postscounter}")
    end
    it 'displays the user\'s post title' do
      expect(page).not_to have_content("Post: #{@user.id}")
    end
    it 'displays the user\'s post text' do
      expect(page).to have_content(@post.text.to_s)
    end
    it 'displays the user\'s recent comments' do
      expect(page).not_to have_content(@comment.text.to_s)
    end
    it 'displays the user\'s number of comments' do
      expect(page).to have_content(@post.commentscounter.to_s)
    end
    it 'displays the user\'s number of likes' do
      expect(page).to have_content(@post.likescounter.to_s)
    end
    it 'displays directs the user to the user\'s post\'s index page' do
      expect(page).to have_link("Post: #{@post.id}", href: user_post_path(@user, @post))
    end
  end
end
