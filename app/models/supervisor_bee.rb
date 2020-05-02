class SupervisorBee < ApplicationRecord
    validates :comb_id, :bee_id, presence: true
    validates :comb_id, uniqueness: {scope: :bee_id}
    
    belongs_to :comb,
    foreign_key: :comb_id,
    class_name: :Comb

    belongs_to :worker_bee,
    foreign_key: :bee_id,
    class_name: :WorkerBee


end
