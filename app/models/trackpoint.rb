class Trackpoint < ApplicationRecord
  belongs_to :user
  scope :lastvalues, ->(id, interval) {
    if (interval && !interval.empty?) || id < 0
      t = Time.now
      case interval
      when 'day'
        t -= 1.day
      when 'week'
        t -= 1.week
      when 'month'
        t -= 1.month
      else
        t -= 1.hour
      end
      where("created_at >= \"#{t}\"")
    else
      where("id > #{id}")
    end
  }

  scope :interval, ->(from, to) {
    where(created_at: Date.strptime(from, '%d/%m/%Y')..Date.strptime(to, '%d/%m/%Y'))
  }

  scope :byname, ->(name) {
    where(name: name)
  }
end
