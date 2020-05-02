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

    
    
    20.times do 
        Comb.create(
            # total_nectar_volume: rand(0..10).ceil,
            sweet_spot: rand(10..15).ceil
        )
        WorkerBee.create(
            nectar: rand(200..20000).ceil, # <---(200..20000) /200 
            bee_name: Faker::Name.first_name,
            comb_id: rand(20).ceil
        )
        
    end
    x = 0
    until x == 20 do
        newBee = SupervisorBee.new(
                bee_id: rand(1..20).ceil,
                comb_id: rand(1..20).floor
            )
        if (newBee.bee_id != newBee.comb_id && newBee.save )
            x += 1 
        end
    end
    
   
    
    i = 0
    5000.times do
        if (i == 21)
            i = 0
        end
            id = rand(20).floor
            current_bee = WorkerBee.find_by(id: i)
            nectar_consumption = rand(200..20000).floor
            pollen_glob_collected = rand(5..17.9)
            
            if (i % 3 == 0) 
                advisement = ["Yes", "No"].sample
            else
                advisement = "n/a"
            end
            PollenCollection.create(
                bee_id: i,
                comb_id: id,
                nectar_consumption: rand(200..20000).floor,
                pollen_glob_collected: rand(5..17.9),
                advisement: advisement
            )
        i += 1
    end


end
