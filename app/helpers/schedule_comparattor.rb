# A schedule comparattor class
class ScheduleComparattor

  # Returns list of available base schedule (eg: university schedule)
  #
  # @param [Calendar] List of block schedule of events
  # @param [Calendar]
  # @return [array] list of `event_keys`
  def self.compare(base_schedule, my_schedule)
    available_schedule = []
    unavailable_schedule = []

    base_schedule.list.each do |day, hour|
      # Compare the day, if it doesn't exist in my schedule, we'll automatically add it to our available schedule
      # Otherwise, we'll compare each day's block of 30 minutes schedule
      if my_schedule.list.dig(day).present?
        hour.each do |minutes, details|
          next if unavailable_schedule.include? (details["event_key"])

          if my_schedule.list.dig(day).dig(minutes).present?
            unavailable_schedule << details["event_key"]
          else
            available_schedule << details["event_key"]
          end
        end
      else
        hour.each do |minutes, details|
          next if available_schedule.include? (details["event_key"])

          available_schedule << details["event_key"]
        end

      end
    end

    available_schedule
  end
end