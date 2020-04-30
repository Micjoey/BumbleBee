class Comb < ApplicationRecord
    validates :bee_id, presence: true

    has_many :bees,
    foreign_key: :bee_id,
    class_name: :WorkerBee

    has_one :supervisor,
    through: :bees,
    source: :supervisors,
    dependent: :destroy


    #  not sure which is a better way to do this
        has_many :pollenCollections,
        through: :bees,
        source: :pollenCollections
    #----------------------
        # has_many :pollenCollections,
        # foreign_key: :comb_id,
        # class_name: :PollenCollection
    # ------------------------------------------

end
