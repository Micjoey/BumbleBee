class WorkerBee < ApplicationRecord

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

    def trial
        workerBee = self
        [
            workerBee.id,
            "WB#{workerBee.id}-C#{workerBee.comb_id}",
             "2-29-20", "100 p/g",
              "#{workerBee.nectar}",
            "n/a",
            "100%"
        ]
    end
    
end
