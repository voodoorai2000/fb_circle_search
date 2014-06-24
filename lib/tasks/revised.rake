require 'facebook_api'
require 'facebook_api_group'
require 'facebook_api_page'

task :search => :environment do
  FacebookApiGroup.new(User.first).search
  FacebookApiPage.new.search
end

task :by_andrex => :environment do
  File.open("#{Rails.root}/lib/revised_circles.txt", "r") do |f|
    f.each_line do |name|
      ["podemos", "podem"].each do |radical|
        FacebookApiGroup.new(User.first).search("#{radical} #{name}")
        FacebookApiPage.new.search("#{radical} #{name}")
      end
    end
  end
end

task :revised => :environment do  
  File.open("#{Rails.root}/lib/revised_circles.txt", "r") do |f|
    f.each_line do |name|
      if circle = Circle.where("lower(unaccent(name)) LIKE ?", "%#{name.strip.downcase}%").first
        circle.update_attribute(:revised, true)
      else
        puts name
      end
    end
  end
end

task :remove_unrelated => :environment do
  Circle.where("lower(unaccent(name)) NOT LIKE ?", "%podem%").map(&:destroy)
end

