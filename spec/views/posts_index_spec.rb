require 'rails_helper'

RSpec.describe 'Post/index', type: :view do
  before(:each) do
    @user = User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Rapper from Detroit'
    )
    @post = Post.create(author: @user, title: 'Hello', text: 'This is one of the first posts')
    @comment = Comment.create(text: 'this is the sixth comment!', author: @user, post: @post)
    Like.create! author: @user, post: @post

    visit "users/#{@user.id}/posts"
  end
  describe "GET '/user/:id/posts/:id'" do
    it 'displays the user\'s post author' do
      expect(page).to have_content(@post.author.name.to_s)
    end
    it 'displays the user\'s recent comments' do
      expect(page).to have_content(@post.text.to_s)
    end
    it 'displays the user\'s post title' do
      expect(page).not_to have_content("Post: #{@user.id}")
    end
    it 'displays the post\'s number of comments' do
      expect(page).to have_content(@post.commentscounter.to_s)
    end
    it 'displays the like\'s number of likes' do
      expect(page).to have_content(@post.likescounter.to_s)
    end
    it 'displays the comment\'s author' do
      expect(page).to have_content(@comment.author.name.to_s)
    end
    it 'displays the user\'s comment' do
      expect(page).to have_content(@comment.text.to_s)
    end
  end
end
