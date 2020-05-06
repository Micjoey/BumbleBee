class Comb < ApplicationRecord
    validates :sweet_spot, presence: true

    
    has_many :bees,
    foreign_key: :bee_id,
    class_name: :WorkerBee

    has_one :supervisor,
    through: :bees,
    source: :supervisors,
    dependent: :destroy

    has_many :pollen_collections,
    through: :bees,
    source: :pollen_collections


end
