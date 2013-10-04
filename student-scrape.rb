require 'nokogiri'
require 'open-uri'

student_links.each do |link|

    flatiron_student = Nokogiri::HTML(open 'http://students.flatironschool.com/students/ivanbrennan.html')

    # the student's name
    student_name = flatiron_student.css("h4").text

    # returns an array of the student's social links; it is quantity agnostic
    student_socials = flatiron_student.css("div.social-icons")
    student_social_links = student_socials.css('a').collect do |social|
         social.attr('href')
    end

    # student quote
    student_quote = flatiron_student.css("h3").first.text

    # biography
    student_biography = flatiron_student.css("div.services").children.css("p").first.text

    # education
    student_education = flatiron_student.css('div.services').children.css("li").collect do |school|
        school.text
    end.join(', ')

    # work
    student_work_company_name = flatiron_student.css('div.services').children.css('h4').text
    student_work_company_blurb = flatiron_student.css('div#ok-text-column-4 p').first.text.strip

    # coder links
    coder_links_array = flatiron_student.css('div.column.fourth a').collect do |link|
        link.attr('href')
    end

    # 

    

end







