require 'nokogiri'
require 'open-uri'
require 'pry'
#write a loop that does all of this for every student page
#puts those student pages into a database


student_links = Nokogiri::HTML(open "http://students.flatironschool.com/index.html").css('h3 a').collect do |student|
    student.attr('href')
end




students_hash = {}
i = 0
student_links.each do |link|

    begin 

    # flatiron_student = Nokogiri::HTML(open 'http://students.flatironschool.com/students/amanda_himmelstoss.html')
    flatiron_student = Nokogiri::HTML(open "http://students.flatironschool.com/#{link}")


    # the student's name
    student_name = flatiron_student.css("h4").text
    students_hash[:"#{student_name}"] = {}

    # returns an array of the student's social links; it is quantity agnostic
    student_socials = flatiron_student.css("div.social-icons")
    students_hash[:"#{student_name}"][:student_social_links] = student_socials.css('a').collect do |social|
         social.attr('href')
    end

    # student quote
    students_hash[:"#{student_name}"][:quote] = flatiron_student.css("h3").first.text

    # biography
    students_hash[:"#{student_name}"][:biography] = flatiron_student.css("div.services").children.css("p").first.text.strip

    # education
    students_hash[:"#{student_name}"][:education] = flatiron_student.css('div.services').children.css("li").collect do |school|
        school.text
    end.join(', ')

    # work
    students_hash[:"#{student_name}"][:work_company] = flatiron_student.css('div.services').children.css('h4').text
    students_hash[:"#{student_name}"][:work_blurb] = flatiron_student.css('div#ok-text-column-4 p').first.text.strip

    # coder links
    students_hash[:"#{student_name}"][:coder_links] = flatiron_student.css('div.column.fourth a').collect do |link|
        link.attr('href')
    end

    # blogs
    students_hash[:"#{student_name}"][:blogs] = flatiron_student.css('div#ok-text-column-3 div + p').first.css('a').collect do |link|
        link.attr('href')
        
    end

    # favorites websites
    students_hash[:"#{student_name}"][:favorite_sites] = flatiron_student.css('div#ok-text-column-3 div + p').last.css('a').collect do |link|
        link.attr('href')
    end

    # personal projects
    students_hash[:"#{student_name}"][:personal_projects_links] = flatiron_student.css('div#ok-text-column-4 div + p').first.css('a').collect do |link|
        link.attr('href')
    end
    students_hash[:"#{student_name}"][:personal_projects_text] = flatiron_student.css('div#ok-text-column-4 p')[1].text.strip

    # flatiron projects
    students_hash[:"#{student_name}"][:flatiron_projects_text] = flatiron_student.css('div#ok-text-column-4 p')[2].text.strip

    #favorite cities
    students_hash[:"#{student_name}"][:favorite_cities] = flatiron_student.css('div#ok-text-column-2 p')[2].css('a').collect do |cities|
        cities.text
    end



    # biography = flatiron_student.css('h3').each do |x|
    #     if x.text == 'Biography'
    #         puts x.parent.
    #     end
    # end
    
    i += 1
    if false
        raise students_hash.inspect
    end

    rescue
    end


end

students_hash

binding.pry







