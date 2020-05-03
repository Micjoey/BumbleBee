require 'action_view'

class WorkerBee < ApplicationRecord

    include ActionView::Helpers::DateHelper

    belongs_to :Comb,
    foreign_key: :bee_id,
    class_name: :Comb

    has_many :supervisors,
    foreign_key: :bee_id,
    class_name: :SupervisorBee,
    dependent: :destroy

    has_many :pollen_collections,
    foreign_key: :bee_id,
    class_name: :PollenCollection

    def is_supervisor?
        workerbee = self
        supervisor_of = workerbee.supervisors.ids
        answer =supervisor_of.include?(workerbee.comb_id)
        [answer, supervisor_of]
    end

    def individual_bee_total_collection
        PollenCollection.where(bee_id: self.id).sum("pollen_glob_collected")
    end

    def average_total_bee_collection
        PollenCollection.average("pollen_glob_collected")
    end

    def all_information_on_bee
        current_bee = self
        pollen_collection = PollenCollection.where(bee_id: self.id, comb_id: self.comb_id)
        @pollen_array = pollen_collection.to_a.map{|p| p}
        return @pollen_array
    end

    def pollen_collected
        current_bee = self
        pollen_collection = PollenCollection.where(bee_id: self.id, comb_id: self.comb_id)
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
        pollen_collection = PollenCollection.where(bee_id: self.id, comb_id: self.comb_id)
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


    
end
