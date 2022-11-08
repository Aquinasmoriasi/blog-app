require 'rails_helper'

# User post index page:

# I can see the user's profile picture.
# I can see the user's username.
# I can see the number of posts the user has written.
# I can see a post's title.
# I can see some of the post's body.
# I can see the first comments on a post.
# I can see how many comments a post has.
# I can see how many likes a post has.
# I can see a section for pagination if there are more posts than fit on the view.
# When I click on a post, it redirects me to that post's show page.

RSpec.describe 'posts/index', type: :system do
  user = User.create!(
    name: 'Tom Okeye',
    photo: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    bio: 'I am a software developer',
    posts_counter: 0
  )
  post1 = Post.create!(title: 'Title1', text: 'MyText1', author: user, comments_counter: 0, likes_counter: 0)
  post2 = Post.create!(title: 'Title2', text: 'MyText2', author: user, comments_counter: 0, likes_counter: 0)

  it 'render the index template' do
    visit user_posts_path(user)
    expect(page).to have_content('Here is a list of posts for a given user')
    expect(page).to have_css("img[src*='#{user.photo}']")
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.posts_counter)
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post1.text[0..99])
    expect(page).to have_content(post1.comments_counter)
    expect(page).to have_content(post1.likes_counter)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post2.text[0..99])
    expect(page).to have_content(post2.comments_counter)
    expect(page).to have_content(post2.likes_counter)
    first(:link, post1.title).click
    expect(page).to have_content('Here is the post you requested')
  end
end
