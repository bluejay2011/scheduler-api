module EventServices
  class GetAvailable
    attr_accessor :available_with, :user_id

    def perform(params)
      @available_with = params[:available_with_user_id]
      @user_id = params[:user_id]

      process
    end

    private

    def process
      my_schedule = CalendarEntity.new(user_id)
      their_schedule = CalendarEntity.new(available_with)

      ## Now let's load the events/schedules to the user's calendar
      my_schedule = update_schedules(user_id, my_schedule)
      their_schedule = update_schedules(available_with, their_schedule)

      ## Now let's compare schedules
      ## This will return an array list of event keys
      available_schedule = ScheduleComparattor.compare(their_schedule, my_schedule)

      # We'll now retrieve the event details for each of the available / non-conflicting schedule
      list = []
      available_schedule.each_with_index do |key, index|
        list << their_schedule.events[key.to_i].event_details
      end

      list
    end

    def update_schedules(user_id, calendar)
      Event.where(user_id: user_id).each do |event|
        calendar.block_schedule(event.name, event.start, event.end)
      end

      calendar
    end
  end
end