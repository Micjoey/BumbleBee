class PollenCollection < ApplicationRecord
    validates :bee_id, :comb_id, presence: true

    belongs_to :bee,
    foreign_key: :bee_id,
    class_name: :WorkerBee


    belongs_to :comb,
    foreign_key: :comb_id,
    class_name: :Comb


   
end
