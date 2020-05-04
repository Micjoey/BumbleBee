class PollenCollection < ApplicationRecord
    validates :bee_id, :comb_id, :nectar_consumption, :pollen_glob_collected, presence: true
    validates :advisement_accepted, inclusion: { in: ["Yes", "No", "n/a"]}

    belongs_to :bee,
    foreign_key: :bee_id,
    class_name: :WorkerBee,
    optional: true


    belongs_to :comb,
    foreign_key: :comb_id,
    class_name: :Comb


    
   
end
