require 'bookmark'
require 'pg'
require 'database_helpers'

describe Bookmark do
  let(:con) { PG.connect test_database }
  let(:test_database) { { dbname: 'bookmark_manager_test', user: ENV['USER'] } }

  describe '.all' do
    it 'makes a query to retrieve all the urls' do
      expect(con).to receive(:exec).with('SELECT * FROM bookmarks')
      con.exec 'SELECT * FROM bookmarks'
      Bookmark.all
    end
  end

    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      bookmark = Bookmark.create(url: "https://www.google.com", title: "Google")
      Bookmark.create(url: "https://www.destroyallsoftware.com", title: "Destroy Software")
      Bookmark.create(url: "https://www.makersacademy.com", title: "Makers")

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Google'
      expect(bookmarks.first.url).to eq 'https://www.google.com'
  end

  describe '.create' do
    it 'creates a new bookmark' do
     bookmark = Bookmark.create(url: 'https://www.google.com', title: 'Google')
     # persisted_data =  persisted_data(id: bookmark.id)

     expect(bookmark).to be_a Bookmark
     # expect(bookmark.id).to eq persisted_data.first['id']
     expect(bookmark.title).to eq 'Google'
     expect(bookmark.url).to eq 'https://www.google.com'

     # expect(bookmark['url']).to eq 'https://www.google.com'
     # expect(bookmark['title']).to eq 'Google'
   end
  end

end
