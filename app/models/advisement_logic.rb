module Advisementlogic
    def advisement_logic(bee_id, comb_id)
    id = rand(20).floor
            current_comb = Comb.find_by(id: comb_id)
            current_bee = WorkerBee.find_by(id: bee_id)

            # if the bee exits than the curre_bee_nectar will be assinged to accordingly, otherwise it will be a random number
            if (current_bee)
                current_bee_nectar = current_bee.nectar
            else
                current_bee_nectar = rand(200..20000)
            end

            nectar_consumption = 0
            on_vacay = rand(1..100) <= 10
            
            # on_vacay determines if the bee took a vacation or not
            if (!on_vacay) 
                until nectar_consumption >= 200 do
                nectar_consumption = (((current_bee_nectar/20000.00) + (rand(-10..10) /100.00) * 20000)).ceil.abs
                end
            end

            # range_variance determines a rang in which the bee will gather pollen
            range_variance = 0
            if (nectar_consumption > current_bee_nectar)
                # if a bee has too much nectar (drunk) it will could potentially do better but
                # most likely will do poorly
                range_variance = rand(-40..5) /100.00
            else
                # if the nectar is less than or equal to the current_bee_nectar 
                # than the bee will have a standard range of obtaining pollen
                range_variance = rand(-20..20) /100.00
            end

            # since pollen and nectar have a correlation, used a percentage
            # to calculate the amount of nectar gathered each time
            # including the variance
            pollen_gathered = (((current_bee_nectar/20000.00) + range_variance)*17.9).abs.round(1)
            # to make sure pollen is always gathered between 5 and 17.9 I made 
            # an if statement to catch outliers
            if (pollen_gathered > 17.9) 
                pollen_gathered = 17.9
            elsif (pollen_gathered < 5)
                pollen_gathered = 5
            end
            
            # every three weeks there is an advisement
            if (i % 3 == 0) 
                # this grabs all pollen data
                all_pollen = PollenCollection
                                        .where(bee_id: id, comb_id: i)
                                        .map{|a| a.pollen_glob_collected}
                all_pollen_length = all_pollen.length 
                
                all_nectar = PollenCollection
                                            .where(bee_id: id, comb_id: i)
                                            .map{|a| a.nectar_consumption}
                all_nectar_length   = all_nectar.length 
                    
                # if the last three weeks exists than continue;
                if all_pollen_length >= 3 && all_nectar_length >= 3
                    # grabs the last three weeks worth of data
                    pollen_average = all_pollen
                        .slice(all_pollen_length-3,all_pollen_length)
                        .sum{|s| s} / 3.00;
                    # finds the average pollen for the last three weeks

                    # finds the last three weeks for nectar
                    nectar_average = all_nectar
                        .slice(all_nectar.length-3, all_nectar.length)
                        .sum{|s| s} / 3
                    # finds average nectar consumed the last three weeks
                        

                    # if the productivity is low than accept advisement
                    if pollen_average < current_comb.sweet_spot && nectar_average < current_bee_nectar
                        # grabs the last advisment number and times it by the suggested increase
                        advisement = ((1-(pollen_average/current_comb.sweet_spot)) * PollenCollection
                                            .where(bee_id: id, comb_id: i)
                                            .map{|a| a.advisement}
                                            .last).floor
                        advisement_accepted = "Yes"
                    else
                        advisement_accepted = "No"
                        advisement = PollenCollection
                                        .where(bee_id: id, comb_id: i)
                                        .map{|a| a.advisement}
                                        .last
                    end
                end
            else
                advisement_accepted = "n/a"
            end
            if !advisement && !!current_bee
                advisement = current_bee.nectar
            end
            # if (i % 3 == 0)
            #     advisement_accepted = ["Yes", "No"].sample
            # else
            #     advisement_accepted = "n/a"
            # end
            PollenCollection.create(
                bee_id: i,
                comb_id: id,
                nectar_consumption: nectar_consumption,
                pollen_glob_collected: pollen_gathered,
                advisement: advisement,
                advisement_accepted: advisement_accepted
            )
end