# A calendar will hold Events per entity
class CalendarEntity
  class ExistingRecord < Exception; end;

  attr_accessor :events, :list
  attr_reader :name

  def initialize(name)
    @events = []
    @list = {}
    @name = name
  end

  def block_schedule(event_name, start_date, end_date)
    event = register(event_name, start_date, end_date)

    temp_date = start_date.dup
    while (temp_date <= end_date) do
      set_schedule(event, temp_date)

      temp_date = temp_date.to_time + 1800
    end

    list
  end

  private

  def register(event_name, start_date, end_date)
    event = EventEntity.new(event_name, start_date, end_date)
    events << event
    key = events.length - 1

    {
      key: key,
      details: event
    }
  end

  def set_schedule(event, event_date)
    day = event_date.strftime('%w').to_i # %w - Day of the week (Sunday is 0, 0..6) 0 - Sunday, 6 - Saturday
    time = event_date.strftime('%H:%M') # Time (Hour, Minute, Second, Subsecond):   %R - 24-hour time (%H:%M)
    arr = time.split(":")
    hour = arr[0].to_i
    minutes = arr[1].to_i

    half_hour = minutes == 30? hour + 0.5: hour

    if list["t_#{day}"].nil?
      # Create an hourly record
      list["t_#{day}"] = {
        "t_#{half_hour}" => {
          "event_key" => event[:key],
          "event_name" => event[:details].name,
          "blocked" => 1
        }
      }
    elsif list["t_#{day}"]["t_#{half_hour}"].nil?
      # create a half hour block record
      list["t_#{day}"]["t_#{half_hour}"] = {
        "event_key" => event[:key],
        "event_name" => event[:details].name,
        "blocked" => 1
      }
    end
  end
end