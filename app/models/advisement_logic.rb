module AdvisementLogic
    
    def self.last_pollen_collection(id, current_comb)
        PollenCollection
            .where(bee_id: id, comb_id: current_comb.id)
            .map{|a| a.advisement}
            .last
    end

    def on_vacay(current_bee_nectar)
        on_vacay = rand(1..100) <= 10
        nectar_consumption = 0
        if (!on_vacay) 
            until nectar_consumption >= 200 do
            nectar_consumption = (((current_bee_nectar/20000.00) + (rand(-10..40) /100.00) * 20000)).abs
            end
        end
        nectar_consumption = nectar_consumption || 0
    end

    def range_variance(nectar_consumption, current_bee_nectar)
        range_variance = 0
        if (nectar_consumption > current_bee_nectar)
            # if a bee has too much nectar (drunk) it will could potentially do better but
            # most likely will do poorly
            range_variance = rand(-15..15) /100.00
        else
            # if the nectar is less than or equal to the current_bee_nectar 
            # than the bee will have a standard range of obtaining pollen
            range_variance = rand(-5..40) /100.00
        end
        range_variance
    end

    def pollen_gathered(nectar_consumption, range_variance)
        pollen_gathered = (((nectar_consumption/20000.00) + range_variance)*17.9).abs.round(1)
        # to make sure pollen is always gathered between 5 and 17.9 I made 
        # an if statement to catch outliers
        if (pollen_gathered > 17.9) 
            pollen_gathered = 17.9
        elsif (pollen_gathered < 5)
            pollen_gathered = 5
        end
        pollen_gathered
    end

    def self.all_pollen(id, comb_id)
        PollenCollection
            .where(bee_id: id, comb_id: comb_id)
            .map{|a| a.pollen_glob_collected}
    end

    def self.all_nectar_consumption(id, comb_id)
        PollenCollection
            .where(bee_id: id, comb_id: comb_id)
            .map{|a| a.nectar_consumption}
    end

    def advisement_sub_logic(id, current_comb, current_bee_nectar, current_bee)
        # every three weeks there is an advisement
        all_pollen = AdvisementLogic.all_pollen(self.id, current_comb.id)

        if all_pollen.length % 3 == 0
            # this grabs all pollen data
            all_pollen_length = all_pollen.length 
            
            all_nectar = AdvisementLogic.all_nectar_consumption(id, current_comb.id)

            all_nectar_length = all_nectar.length 
                
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
                if pollen_average < current_comb.sweet_spot && nectar_average <= current_bee_nectar
                    # grabs the last advisment number and times it by the suggested increase
                    # advisement_accepted = "Yes"
                    advisement = ((1-(current_comb.sweet_spot/20000).ceil) * 20000).ceil
                elsif (nectar_average > current_bee_nectar)
                    advisement = ((1-(current_comb.sweet_spot/20000).ceil) * 20000).ceil
                else 
                    advisement = current_bee_nectar
                end
            end
        end
        if !advisement && !!current_bee
            advisement = AdvisementLogic.last_pollen_collection(id, current_comb)
        end
        
        if !!advisement && advisement < 200 
            advisement = 200
        elsif advisement == 20000
            advisement = rand(15000..18000)
        elsif !advisement
            advisement = PollenCollection.average("pollen_consumption")
        end
        
        advisement_accepted = "n/a"
        [advisement, advisement_accepted, all_pollen.length]
    end


    
    def advisement_logic
        current_comb = Comb.find_by(id: self.comb_id)
        current_bee = self

        # if the bee exits than the current_bee_nectar will be assinged to accordingly, otherwise it will be a random number
        # current_bee_nectar = rand(200..20000)
        current_bee_nectar = current_bee.nectar
        # !!current_bee ?  current_bee_nectar = current_bee.nectar : current_bee_nectar = rand(200..20000)
            

        # on_vacay determines if the bee took a vacation or not
        nectar_consumption = on_vacay(current_bee_nectar).ceil

        # range_variance determines a rang in which the bee will gather pollen
        range_variance = range_variance(nectar_consumption, current_bee_nectar)

        # since pollen and nectar have a correlation, used a percentage
        # to calculate the amount of nectar gathered each time
        # including the variance
        pollen_gathered = pollen_gathered(nectar_consumption, range_variance)
       
        
        # every three weeks there is an advisement
        advisement = advisement_sub_logic(current_bee.id, current_comb, current_bee_nectar, current_bee)


        [current_bee.id, current_comb.id, nectar_consumption, pollen_gathered, advisement[0], advisement[1], advisement[2]]
    end

    def advisement_form
        [
            ["bee_id", self.advisement_logic[0]],
            ["comb_id", self.advisement_logic[1]],
            ["nectar_consumption", self.advisement_logic[2]],
            ["pollen_glob_collected", self.advisement_logic[3]],
            ["advisement", self.advisement_logic[4]],  
        ]
    end

end