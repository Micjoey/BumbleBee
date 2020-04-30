class WorkerBee < ApplicationRecord
    belongs_to :Comb,
    foreign_key: :bee_id,
    class_name: :Comb

    has_many :supervisors,
    foreign_key: :bee_id,
    class_name: :SupervisorBee
    # dependent: :destory
end
