# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user_1 = User.create({name: "bob", email: "bob@fake", password: "123456"})
user_2 = User.create({name: "jane", email: "jane@fake", password: "123456"})

doctor_1 = Doctor.create({name: "doctor_jivago", photo: "photo_url", bio: "nice doctor", profession: "doctor maker"})

now = DateTime.now
appointment_1 = Appointment.create({user: user_1, doctor: doctor_1, date: now})
appointment_2 = Appointment.create({user: user_1, doctor: doctor_1, date: now.next_day})