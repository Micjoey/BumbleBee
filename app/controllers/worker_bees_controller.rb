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

    

    private

    def worker_bee_params
        params.require(:worker_bee).permit(:nectar, :bee_name, :comb_id, :pollen_globs)
    end
end
