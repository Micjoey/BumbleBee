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
                bee_id: rand(0..20).ceil,
                comb_id: rand(0..20).floor
            )
        if (newBee.bee_id != newBee.comb_id && newBee.save )
            x += 1 
        end
    end
    
   
    
#    100.times do 
#     i = 0  
#     visited = {}
#         60.times do
#             bee_id = rand(20.ceil).ceil
#             visited[bee_id] == 0 ? visited[bee_id] += 1 : visited[bee_id] == 0
#             if (visited[bee_id] == 10) 
#                 until visited[bee_id] != 10
#                     bee_id = rand(20.ceil).ceil
#                 end
#             end

#             PollenCollection.create(
#                 bee_id: bee_id,
#                 comb_id: i,
#                 nectar_consumption: rand(200..20000).floor,
#                 pollen_glob_collected: rand(5..17.9)
#             )

#     i += 1
#         end 
#    end
    i = 0
    5000.times do
        if (i == 20)
            i = 0
        end
            id = rand(20).floor
            PollenCollection.create(
                bee_id: i,
                comb_id: id,
                nectar_consumption: rand(200..20000).floor,
                pollen_glob_collected: rand(5..17.9)
            )
        i += 1
    end


end
