require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    database = ENV['ENVIRONMENT'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
    con = PG.connect(dbname: database, user: ENV['USER'])
    rows = con.exec('SELECT * FROM bookmarks')
    rows.map do |row|
      Bookmark.new(id: row['id'], title: row['title'], url: row['url'])
    end
  end

  def self.create(url:, title:)
    database = ENV['ENVIRONMENT'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
    con = PG.connect(dbname: database, user: ENV['USER'])
    @title = title
    @url = url
    con.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title;")
  end

  def test 
  end
end
