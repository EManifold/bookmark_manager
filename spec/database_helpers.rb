require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  rows = connection.query("SELECT * FROM bookmarks WHERE id = #{id};")
  rows.first
end
