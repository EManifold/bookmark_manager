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
    # return false unless is_url?(url)
    database = ENV['ENVIRONMENT'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
    con = PG.connect(dbname: database, user: ENV['USER'])
    result = con.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end
end
