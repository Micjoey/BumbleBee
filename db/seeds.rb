# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ActiveRecord::Base.transaction do

    WorkerBee.destroy_all
    Comb.destroy_all
    SupervisorBee.destroy_all

    require 'faker'
    include Faker

    i = 1
    40.times do 
       bee = WorkerBee.create(
            bee_name: Faker::Name.first_name,
            pollen_globs: rand(1..30),
            nectar: rand(1..30),
            comb_id: i
        )
    i += 1
    end

    x = 1
    40.times do 
       comb = Comb.create(
            bee_id: x-1,
            supervisor_bee_id: x
        )
        SupervisorBee.create(
            bee_id: x,
            comb_id: x
        )
    x += 1
    end

    40.times do
        

    end
   
end
