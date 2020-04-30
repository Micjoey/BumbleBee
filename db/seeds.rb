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
    PollenCollection.destroy_all

    require 'faker'
    include Faker

    

    i = 0
    20.times do 
        Comb.create(
            nectar_volume: rand(0..10).ceil,
            sweet_spot: rand(10..15).ceil
        )
        WorkerBee.create(
            pollen_globs: rand(0..15).ceil,
            nectar: rand(1..15).ceil,
            bee_name: Faker::Name.first_name,
            comb_id: i
        )
        
    i += 1
    end

    x = 0
   until x == 20 do
        newBee = SupervisorBee.new(
                bee_id: rand(0..20).ceil,
                comb_id: rand(0..20).floor
            )
        if (newBee.bee_id != newBee.comb_id && newBee.save )
            x += 1 
        end
   end
   

   100.times do 
        PollenCollection.create(
            bee_id: rand(20).ceil,
            comb_id: rand(20).floor,
            pollen_glob_collected: rand(10..15)
        )


   end


end
