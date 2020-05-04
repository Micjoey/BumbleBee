

class WorkerBee < ApplicationRecord
    include WorkerBeeHelperMethod
    # WorkerBee --> WorkerBeeHelperMethod --> AdvisementLogic

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
   
    

end
