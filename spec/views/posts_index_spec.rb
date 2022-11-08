require 'rails_helper'

RSpec.describe 'posts/index', type: :system do
  user = User.create!(
    name: 'Tom Okeye',
    photo: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    bio: 'I am a software developer',
  )
  post1 = Post.create!(title: 'Title1', text: 'MyText1', author: user)
  post2 = Post.create!(title: 'Title2', text: 'MyText2', author: user)

  it 'render the index template' do
    visit user_posts_path(user)
    expect(page).to have_content('Here is a list of posts for a given user')
    expect(page).to have_css("img[src*='#{user.photo}']")
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.postscounter)
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post1.text[0..99])
    expect(page).to have_content(post1.commentscounter)
    expect(page).to have_content(post1.likescounter)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post2.text[0..99])
    expect(page).to have_content(post2.commentscounter)
    expect(page).to have_content(post2.likescounter)
    first(:link, post1.title).click
    expect(page).to havecontent('Here is the post you requested')
  end
end
