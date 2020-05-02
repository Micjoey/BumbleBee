
class PollenCollectionsController < ApplicationController
    def create
        @pollen_collection = PollenCollection.new(pollen_collection_params)
        if @pollen_collection.save
            @worker_bee = WorkerBee.find(@pollen_collection.bee_id)
        else
            render json: @pollen_collection.errors.full_messages, status: 406
        end
    end

    # def show
    #     @pollen_collection = @pollen_collection.find(params[:bee_id])
    # end
    

    def destroy
        @pollen_collection = PollenCollection.find(params[:id])
        if @pollen_collection.destroy
            @worker_bee = WorkerBee.find(@pollen_collection.bee_id)
            render :show
        else
            render json: @pollen_collection.errors.full_messages, status: 406
        end
    end

    private
    def pollen_collection_params
        params.require(:pollen_collection).permit(:bee_id, :comb_id, :id, :pollen_glob_collected, :advisement_accepted, :advisement,:nectar_consumption)
    end
end
