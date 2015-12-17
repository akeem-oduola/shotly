class Click < ActiveRecord::Base
  belongs_to :link, counter_cache: true
  def self.count_days_bar(identifier,num_of_days)
    clicks = count_by_date_with(identifier,num_of_days)
    data, labels = [], []
    clicks.each {|click| data << click[1]; labels << "#{click[0].day}/#{click[0].month}" }
    "http://chart.apis.google.com/chart?chs=820x180&cht=bvs&chxt=x&chco=a4b3f4&chm=N,000000,0,-1,11&chxl=0:|#{labels.join('|')}&chds=0,#{data.sort.last+10}&chd=t:#{data.join(',')}"
  end

  def self.count_country_chart(identifier,map)
    countries, count = [], []
    count_by_country_with(identifier).each {|click| countries << click.country; count << click.count }
    chart = {}
    chart[:map] = "http://chart.apis.google.com/chart?chs=440x220&cht=t&chtm=#{map}&chco=FFFFFF,a4b3f4,0000FF&chld=#{countries.join('')}&chd=t:#{count.join(',')}"
    chart[:bar] = "http://chart.apis.google.com/chart?chs=320x240&cht=bhs&chco=a4b3f4&chm=N,000000,0,-1,11&chbh=a&chd=t:#{count.join(',')}&chxt=x,y&chxl=1:|#{countries.reverse.join('|')}"
    return chart
  end

  def self.count_by_date_with(identifier,num_of_days)
    start_date = Date.today - num_of_days.day
    end_date = Date.today + 1
    clicks = Click.select("date(created_at) as date, count(*) as count")
                  .where("link_id = #{identifier} AND created_at >= to_timestamp(#{start_date}) AND created_at < to_timestamp(#{end_date})")
                  .group("date(created_at)")
    dates = (Date.today-num_of_days..Date.today)
    results = {}
    dates.each { |date|
      clicks.each { |click| results[date] = click.count if click.date == date }
      results[date] = 0 unless results[date]
    }
    results.sort.reverse
  end

  def self.count_by_country_with(identifier)
    Click.select("country, count(*) as count").where("link_id = #{identifier}")
         .group("country")
  end
end
