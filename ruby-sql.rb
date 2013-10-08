require "open-uri"
require "Nokogiri"
require "sqlite3"
 
def create_db
  schema = students.first.keys.join(", ")
  rows = db.execute <<-SQL
    create table students (
      schema
    );
  SQL
end
 
def parse_profile(profile_url)
  profile_page = Nokogiri::HTML(open(profile_url))
 
  # Insert data
  students_arr.each do |student_hash|
    student_hash.each do |pair|
      db.execute "insert into students values ( ?, ?)", pair
    end
  end
end