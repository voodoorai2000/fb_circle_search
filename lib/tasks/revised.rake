task :revised => :environment do  
  File.open("#{Rails.root}/lib/revised_circles.txt", "r") do |f|
    f.each_line do |name|
      if circle = Circle.where("lower(name) LIKE ?", "%#{name.strip.downcase}%").first
        puts name
        circle.update_attribute(:revised, true)
      end
    end
  end
end