class WorkerBeesController < ApplicationController
    include AdvisementLogic


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
        average_bee_collection
        render :index
    end
    
    def show
        @worker_bee = WorkerBee.find_by(id: params[:id])
        if @worker_bee
            gon.watch.worker_bee = @worker_bee
            render :show
        else
            redirect_to worker_bees_url
        end

    end

    def edit
        @worker_bee = WorkerBee.find_by(id: params[:id])
        render :edit
    end

    def update
        @worker_bee = WorkerBee.find(params[:id])
        if @worker_bee.update(worker_bee_params)
            render :show
        else
            render json: @worker_bee.errors.full_messages, status: 406
        end
    end

    def average_bee_collection
        @worker_bee_averages = PollenCollection.average("pollen_glob_collected").round(2)
    end

    
    

    def supervisor
        supervisor = SupervisorBee.where(bee_id: self.id, comb_id: self.comb_id)
        current_bee = self
        @supervisor = (current_bee.id == supervisor.bee_id && current_bee.comb_id == supervisor.comb_id) ? true : false
    end
    

   

    private

    def worker_bee_params
        params.require(:worker_bee).permit(:nectar, :bee_name, :comb_id, :pollen_globs)
    end
end
