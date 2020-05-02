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

    has_many :pollenCollections,
    foreign_key: :bee_id,
    class_name: :PollenCollection

    def supervisor?
        workerBee = self
        isSupervisor = !!workerBee.supervisors
    end

    def individualBeeTotalCollection
        PollenCollection.where(bee_id: self.id).sum("pollen_glob_collected")
    end

    def averageTotalBeeCollection
        PollenCollection.average("pollen_glob_collected")
    end

    def allGlobs
        current_bee = self
        pollen_collection = PollenCollection.where(bee_id: self.id, comb_id: self.comb_id)
        @pollen_array = pollen_collection.to_a.map{|p| p}
        return @pollen_array
    end

    def pollenCollected
        current_bee = self
        pollen_collection = PollenCollection.where(bee_id: self.id, comb_id: self.comb_id)
        @pollen_array = pollen_collection.to_a.map{|p| p.pollen_glob_collected}
    end
    def nectarUsed
        current_bee = self
        pollen_collection = PollenCollection.where(bee_id: self.id, comb_id: self.comb_id)
        @pollen_array = pollen_collection.to_a.map{|p| p.nectar_consumption}
    end

    

    def allCombsPartOf
        current_bee = self
        pollen_collection = PollenCollection.where(bee_id: self.id)
        pollen_array = pollen_collection.to_a.map{|p| p.comb_id}.uniq().sort()
    end

    def time
        time_ago_in_words(date_created)
    end

    def allGlobs2
        gon.allGlobs = self.allGlobs
    end
    
    
end
