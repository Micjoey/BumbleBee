class Comb < ApplicationRecord

    has_many :bees,
    foreign_key: :bee_id,
    class_name: :WorkerBee

    has_one :supervisor,
    through: :bees,
    source: :supervisors
    dependent: :destroy
end
