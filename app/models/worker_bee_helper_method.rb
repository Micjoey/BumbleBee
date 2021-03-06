module WorkerBeeHelperMethod
    include AdvisementLogic
    def is_supervisor?
        workerbee = self
        supervisor_of = workerbee.supervisors.ids
        answer =supervisor_of.include?(workerbee.comb_id)
        [answer, supervisor_of]
    end
    
    def self.all_pollen_collection(id, comb_id)
        #This is getting all pollen collected by a specific bee and comb
        PollenCollection.where(bee_id: id, comb_id: comb_id)
    end

    def individual_bee_total_collection
        # this is the sum of pollen collected by a bee
        PollenCollection.where(bee_id: self.id).sum("pollen_glob_collected")
    end

    def average_total_bee_collection
        # average pollen collected by all bees
        PollenCollection.average("pollen_glob_collected")
    end

    def all_information_on_bee
        # all information regarding a bee
        current_bee = self
        pollen_collection = WorkerBeeHelperMethod.all_pollen_collection(self.id, self.comb_id)
        all_information = pollen_collection.to_a.map{|p| p} #converting the object into an array
        all_information
    end

    def advisement_accepted
        count_of_yes = 0.0000
        count_of_no = 0.0000
        accepted_percent = {}
        self.all_information_on_bee.each_with_index do |data, idx|
            if data.advisement_accepted == "Yes"
                count_of_yes += 1
            elsif data.advisement_accepted == "No"
                count_of_no += 1
            end
            accepted_percent[idx] = (count_of_yes/(count_of_no + count_of_yes)) * 100
        end
        accepted_percent
    end

    def pollen_collected
        current_bee = self
        # gets all the pollen that a specific bee has gathered in a specific comb
        pollen_collection = WorkerBeeHelperMethod.all_pollen_collection(self.id, self.comb_id)
        #converts it to an array that is accessable
        @pollen_array = pollen_collection.to_a.map{|p| p.pollen_glob_collected}
    end
    
    def relevant_math
        #this generates a math object consisting of a rand numbers in order of
        # usage
        math_object = [rand(200..20000),
            rand(1..100) <= 10,
            (((self.nectar/20000.00) + (rand(-10..10) /100.00) * 20000)).ceil.abs,
            rand(-40..5) /100.00,
            rand(-20..20) /100.00]
    end

    def nectar_used
        current_bee = self
        pollen_collection = WorkerBeeHelperMethod.all_pollen_collection(self.id, self.comb_id)
        @nectar_array = pollen_collection.to_a.map{|p| p.nectar_consumption}
    end

    def target_pollen
        sweet_spot = Comb.where(id: self.comb_id).to_a.map{|p| p.sweet_spot}[0]
    end

    def all_combs_part_of
        current_bee = self
        pollen_collection = PollenCollection.where(bee_id: self.id)
        pollen_array = pollen_collection.to_a.map{|p| p.comb_id}.uniq().sort()
    end

    def last_advisement
       last_advisement = PollenCollection
            .where(bee_id: self.id, comb_id: self.comb_id)
            .map{|a| a.advisement}
            .last

        last_advisement_acceptance = PollenCollection
                                        .where(bee_id: self.id, comb_id: self.comb_id)
                                        .map{|a| a.advisement_accepted}
                                        .last
        if (!last_advisement || !last_advisement_acceptance) 
            last_advisement = PollenCollection.average('nectar_consumption')
            last_advisement_acceptance = 'n/a'
        end
        [last_advisement, last_advisement_acceptance]
    end


end