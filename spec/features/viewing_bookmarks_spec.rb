
feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do

    Bookmark.create(url: 'https://www.makersacademy.com', title: 'Makers')
    Bookmark.create(url: 'https://www.destroyallsoftware.com', title: 'Destroy Software')
    Bookmark.create(url: 'https://www.google.com', title: 'Google')

    visit('/bookmarks')

    expect(page).to have_link("Makers", href: 'https://www.makersacademy.com')
    expect(page).to have_link("Destroy Software", href: 'https://www.destroyallsoftware.com')
    expect(page).to have_link("Google", href: 'https://www.google.com')
  end
end
