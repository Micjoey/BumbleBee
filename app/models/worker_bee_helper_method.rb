module WorkerBeeHelperMethod
    include AdvisementLogic

    def is_supervisor?
        workerbee = self
        supervisor_of = workerbee.supervisors.ids
        answer =supervisor_of.include?(workerbee.comb_id)
        [answer, supervisor_of]
    end
    def self.all_pollen_collection(id, comb_id)
        PollenCollection.where(bee_id: id, comb_id: comb_id)
    end

    def individual_bee_total_collection
        PollenCollection.where(bee_id: self.id).sum("pollen_glob_collected")
    end

    def average_total_bee_collection
        PollenCollection.average("pollen_glob_collected")
    end

    def all_information_on_bee
        current_bee = self
        pollen_collection = WorkerBeeHelperMethod.all_pollen_collection(self.id, self.comb_id)
        all_information = pollen_collection.to_a.map{|p| p}
        all_information
    end

    def advisement_accepted
        count_of_yes = 0.0000
        count_of_no_na = 0.0000
        accepted_percent = {}
        self.all_information_on_bee.each_with_index do |data, idx|
            if data.advisement_accepted == "Yes"
                count_of_yes += 1
            else
                count_of_no_na += 1
            end
            accepted_percent[idx] = (count_of_yes/(count_of_no_na + count_of_yes)) * 100
        end
        accepted_percent
    end

    def pollen_collected
        current_bee = self
        pollen_collection = WorkerBeeHelperMethod.all_pollen_collection(self.id, self.comb_id)
        @pollen_array = pollen_collection.to_a.map{|p| p.pollen_glob_collected}
    end
    
    def relevant_math
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

    def in_need_of_advisement
    end


end