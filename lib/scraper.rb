require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    Nokogiri::HTML(html)
  end

  def get_courses
    get_page.css(".post")
  end

  def make_courses

    get_courses.each do |new_post|
      new_course = Course.new
      new_course.title = post.css("h2").text
      new_course.schedule = post.css("date").text
      new_course.description = post.css("p").text
    end
    get_courses 
  end

end
