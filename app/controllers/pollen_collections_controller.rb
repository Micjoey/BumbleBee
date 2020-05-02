
class PollenCollectionsController < ApplicationController
    def create
        @pollencollection = PollenCollection.new(pollen_collection_params)
        if @pollencollection.save
            @worker_bee = WorkerBee.find(@pollencollection.bee_id)
        else
            render json: @pollencollection.errors.full_messages, status: 406
        end
    end

    # def show
    #     @pollencollection = @pollencollection.find(params[:bee_id])
    # end
    

    def destroy
        @pollencollection = PollenCollection.find(params[:id])
        if @pollencollection.destroy
            @worker_bee = WorkerBee.find(@pollencollection.bee_id)
            render :show
        else
            render json: @pollencollection.errors.full_messages, status: 406
        end
    end

    private
    def pollen_collection_params
        params.require(:pollen_collection).permit(:bee_id, :comb_id, :id, :pollen_glob_collected, :advisement_accepted, :advisement,:nectar_consumption)
    end
end
