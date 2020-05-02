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
        currentComb = Comb.create(
            # total_nectar_volume: rand(0..10).ceil,
            sweet_spot: rand(10..15).ceil
        )
        currentWorker = WorkerBee.create(
            nectar: rand(200..20000), 
            # nectar: beeNectar, 
            bee_name: Faker::Name.first_name,
            comb_id: Comb.last.id
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
            current_comb = Comb.find_by(id: id)
            current_bee = WorkerBee.find_by(id: i)
            if (current_bee)
                current_bee_nectar = current_bee.nectar
            else
                current_bee_nectar = rand(200..20000)
            end

            nectar_consumption = 0
            on_vacay = rand(1..100) <= 10
            
            
            if (!on_vacay) 
                until nectar_consumption >= 200 do
                nectar_consumption = (((current_bee_nectar/20000.00) + (rand(-10..10) /100.00) * 20000)).ceil.abs
                end
            end
            range_variance = 0
            if (nectar_consumption > current_bee_nectar)
                range_variance = rand(-40..10) /100.00
            else
                range_variance = rand(0..40) /100.00
            end

            pollen_gathered = (((current_bee_nectar/20000.00) + range_variance)*17.9).abs.round(1)
            if (pollen_gathered > 17.9) 
                pollen_gathered = 17.9
            elsif (pollen_gathered < 5)
                pollen_gathered = 5
            end
            
            if (i % 3 == 0) 
                advisement_sum_last_three_weeks = PollenCollection
                                        .where(bee_id: id, comb_id: i)
                                        .map{|a| a.pollen_glob_collected}
                advisement_sum_last_three_weeks.slice(advisement_sum_last_three_weeks.length-3, advisement_sum_last_three_weeks.length)
                                        
                pollen_average = advisement_sum_last_three_weeks.sum{|s| s} / advisement_sum_last_three_weeks.length
                nectar_sum_last_three_weeks = PollenCollection
                                        .where(bee_id: id, comb_id: i)
                                        .map{|a| a.nectar_consumption}
                nectar_sum_last_three_weeks.slice(nectar_sum_last_three_weeks.length-3, nectar_sum_last_three_weeks.length)
                nectar_average = nectar_sum_last_three_weeks.sum{|s| s} / nectar_sum_last_three_weeks.length

                if (pollen_average < current_comb.sweet_spot && nectar_average < current_bee_nectar)
                    advisement += ((1-(pollen_average/current_comb.sweet_spot)) * PollenCollection
                                        .where(bee_id: id, comb_id: i)
                                        .map{|a| a.advisement}.last)
                    advisement_accepted = "Yes"
                else
                    advisement_accepted = "no"
                end
            else
                advisement_accepted = "n/a"
            end
            PollenCollection.create(
                bee_id: i,
                comb_id: id,
                nectar_consumption: nectar_consumption,
                pollen_glob_collected: pollen_gathered,
                advisement: advisement,
                advisement_accepted: advisement_accepted
            )
        i += 1
    end


end
