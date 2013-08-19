module ApplicationHelper

  def full_title(page_title)
    base_title = "Question & Answer"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def to_jalali(date, options = {})
    jalali_date = JalaliDate.new(date)	
    if options[:standard]
      jalali_date.strftime("%e %b %Y").to_farsi
    elsif options[:just_time]
      "ساعت " + jalali_date.strftime("%H:%M").to_farsi
    else
      jalali_date.strftime("%A %e %b %Y - %H:%M").to_farsi
    end
  end
  
  
end
