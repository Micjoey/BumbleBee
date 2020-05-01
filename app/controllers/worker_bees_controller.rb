class WorkerBeesController < ApplicationController

    def create
        @worker_bee = WorkerBee.new(worker_bee_params)
        if @worker_bee.save
            render :index
        else
            render json: @worker_bee.errors.full_messages, status: 406
        end
    end

    def index
        @worker_bees = WorkerBee.all
        averageBeeCollection
        render :index
    end

    def show
        @worker_bee = WorkerBee.find(params[:id])
        render :show
    end

    def update
        @worker_bee = WorkerBee.find(params[:id])
        if @worker_bee.update(comb_params)
            render :show
        else
            render json: @worker_bee.errors.full_messages, status: 406
        end
    end

    def averageBeeCollection
        # @worker_bee_pollen_sum = PollenCollection.where(bee_id: params[:id]).sum("pollen_glob_collected")
        @worker_bee_averages = PollenCollection.average("pollen_glob_collected")
    end

    
    def simulateWeek
        current_bee = self
        pollen_collected = rand(5..17.9)
        nectar_given = rand(2..3)
        total_nectar = 0
        nectar_given.times do
            will_skip = rand(100) <= 10
            if (!will_skip) 
                total_nectar += rand(2..200).ceil
            end
        end
        
        new_pollen_collection = PollenCollection.new(
            bee_id: current_bee.id,
            comb_id: current_bee.comb_id,
            pollen_glob_collected: pollen_collected
        )
        # if (new_pollen_collection.save) {
        #     render :show
        # }

    end
    

    

    private

    def worker_bee_params
        params.require(:worker_bee).permit(:nectar, :bee_name, :comb_id, :pollen_globs)
    end
end
