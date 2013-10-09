require "open-uri"
require "Nokogiri"
require "sqlite3"
require_relative "student-scrape.rb"
require 'pry'

# this should be in the scraper file
# students_array = Nokogiri::HTML(open(profile_url))


# Open a database
def create_db
  SQLite3::Database.new "flatiron.db"
end


def create_table(database)
  rows = database.execute <<-whatever
    CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    social_links TEXT,
    quote TEXT,
    biography TEXT,
    education TEXT,
    work_company TEXT,
    work_blurb TEXT,
    coder_links TEXT,
    blogs TEXT,
    fav_websites TEXT,
    personal_projects_links TEXT,
    personal_projects_text TEXT,
    flatiron_projects TEXT,
    fave_cities TEXT
    );
  whatever
end

db = create_db
create_table(db)
# scrape
students_hash = scrape
binding.pry

ins = db.prepare('INSERT INTO students
      (name, 
      social_links,
      quote,
      biography,
      education,
      work_company,
      work_blurb,
      coder_links,
      blogs,
      fav_websites,
      personal_projects_links,
      personal_projects_text,
      flatiron_projects,
      fave_cities
      )
      VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)')
puts "SQL Prepared!"

students_hash.each do |student_name, student_hash|
  s = ["#{student_name}", 
       "#{student_hash[:social_links]}",
       "#{student_hash[:quote]}",
       "#{student_hash[:biography]}",
       "#{student_hash[:education]}",
       "#{student_hash[:work_company]}",
       "#{student_hash[:work_blurb]}",
       "#{student_hash[:coder_links]}",
       "#{student_hash[:blogs]}",
       "#{student_hash[:fav_websites]}",
       "#{student_hash[:personal_projects_links]}",
       "#{student_hash[:personal_projects_text]}",
       "#{student_hash[:flatiron_projects_text]}",
       "#{student_hash[:fave_cities]}"]
  ins.execute(*s)

  puts "loaded!"

end


