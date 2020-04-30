class Comb < ApplicationRecord
    validates :bee_id, :supervisor_bee_id, presence: true

    has_many :bees,
    foreign_key: :bee_id,
    class_name: :WorkerBee

    has_one :supervisor,
    through: :bees,
    source: :supervisors,
    dependent: :destroy

    has_many :pollenCollections,
    foreign_key: :bee_id,
    class_name: :PollenCollection
end
