require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:each) do
      @user = User.create(
        name: 'Tom',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Rapper from Detroit'
      )
      get "/users/#{@user.id}/posts"
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
  end
  describe 'GET #show' do
    before(:each) do
      @user = User.create(
        name: 'Tom',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Rapper from Detroit'
      )
      @post = Post.create(author: @user, title: 'Hello', text: 'This is one of the first posts')
      get "/users/#{@user.id}/posts/#{@post.id}"
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'show' template" do
      expect(response).to render_template('posts/show')
    end
    it 'shows if the specific user template is rendered correctly' do
      expect(response.body).to include('back to all users')
    end
  end
end
