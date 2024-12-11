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

      my_schedule = update_schedules(user_id, my_schedule)
      their_schedule = update_schedules(available_with, their_schedule)

      ## Now let's compare schedule of university vs my schedule
      available_schedule = ScheduleComparattor.compare(their_schedule, my_schedule)

      list = []
      available_schedule.each_with_index do |key, index|
        list << their_schedule.events[key.to_i].event_details
      end

      list
    end

    def update_schedules(user_id, calendar)
      Event.where(user_id: user_id).each do |event|
        # datetime = DateTime.strptime(@value, '%Y-%m-%d')
        calendar.block_schedule(event.name, event.start, event.end)
      end

      calendar
    end
  end
end