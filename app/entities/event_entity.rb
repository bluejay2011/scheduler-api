# An event represents a block of time within the day
class EventEntity
  attr_reader :name, :start_date, :end_date, :booked

  def initialize(event_name, start_date, end_date)
    @name = event_name
    @start_date = start_date
    @end_date = end_date
  end

  def book
    @booked = true
  end

  def unbook
    @booked = false
  end

  def booked?
    booked === true
  end

  def event_details
    {
      start_date: start_date,
      end_date: end_date,
      name: name,
      booked: booked?
    }
  end
end