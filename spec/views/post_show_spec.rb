require 'rails_helper'

RSpec.describe 'posts/show', type: :system do
  user = User.create!(
    name: 'Tom Okeye',
    photo: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    bio: 'I am a software developer',
  )
  post = Post.create!(title: 'Title1', text: 'MyText1', author: user)
  comment = Comment.create!(post: post, author: user, text: 'This is a good post')

  it 'render the show template' do
    visit user_post_path(user, post)
    expect(page).to have_content('Here is the post you requested')
    expect(page).to have_content(user.name)
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.text)
    expect(page).to have_content(post.commentscounter)
    expect(page).to have_button("#{post.likescounter} Likes")
    expect(page).to have_content(comment.author.name)
    expect(page).to have_content(comment.text)
  end
end
