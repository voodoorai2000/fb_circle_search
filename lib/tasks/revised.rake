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
