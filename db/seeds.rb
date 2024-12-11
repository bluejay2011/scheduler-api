# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Convenient data based on the example of example
if Rails.env.development?
  if User.first.blank? && Event.first.blank?
    # Scenario 1 based on example
    up1 = User.create(name: "University Person 1")
    sp1 = User.create(name: "Student Person 1")

    Event.create(name: "University SC1 Event 1", start: "2018-12-19 16:00:00", end: "2018-12-19 17:00:00", user_id: up1.id)
    Event.create(name: "University SC1 Event 2", start: "2018-12-20 9:30:00", end: "2018-12-20 11:30:00", user_id: up1.id)
    Event.create(name: "University SC1 Event 3", start: "2018-12-21 9:00:00", end: "2018-12-21 11:00:00", user_id: up1.id)

    Event.create(name: "Student SC1 Event 1", start: "2018-12-19 16:00:00", end: "2018-12-19 17:00:00", user_id: sp1.id)
    Event.create(name: "Student SC1 Event 2", start: "2018-12-20 9:00:00", end: "2018-12-20 10:00:00", user_id: sp1.id)


    # Scenario 2 based on example
    up2 = User.create(name: "University Person 2")
    sp2 = User.create(name: "Student Person 2")

    Event.create(name: "University SC2 Event 1", start: "2018-12-19 16:00:00", end: "2018-12-19 17:00:00", user_id: up2.id)
    Event.create(name: "University SC2 Event 2", start: "2018-12-20 9:30:00", end: "2018-12-20 11:30:00", user_id: up2.id)
    Event.create(name: "University SC2 Event 3", start: "2018-12-28 13:00:00", end: "2018-12-28 15:00:00", user_id: up2.id)
    Event.create(name: "University SC2 Event 4", start: "2018-12-29 13:00:00", end: "2018-12-29 14:00:00", user_id: up2.id)

    Event.create(name: "Student SC2 Event 1", start: "2018-12-19 16:00:00", end: "2018-12-19 17:00:00", user_id: sp2.id)
    Event.create(name: "Student SC2 Event 2", start: "2018-12-20 09:00:00", end: "2018-12-20 10:00:00", user_id: sp2.id)
    Event.create(name: "Student SC2 Event 3", start: "2018-12-21 13:00:00", end: "2018-12-21 13:30:00", user_id: sp2.id)
  end
end