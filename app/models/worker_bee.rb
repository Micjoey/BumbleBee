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


    def totalPollenCollected
        worker_bee = self
        sum_of_pollen = PollenCollection.joins("")

    end

    #   def search
    #     search = "%#{params[:query].downcase}%"
    #     @decks = Deck.joins(:cards).where("lower(decks.title) LIKE ? OR lower(cards.front_text) LIKE ? OR lower(cards.back_text) LIKE ?", search, search, search).select(:id, :title, :author_id).distinct
    #     render 'api/decks/search'
    #   end
end
