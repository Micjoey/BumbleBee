class CombsController < ApplicationController
    def index
        @combs = Comb.all
        render :index
    end

    def show
        @comb = Comb.find(params[:id])
        render :show
    end

    def update
        @comb = Comb.find(params[:id])
        if @comb.update(comb_params)
            render :show
        else
            render json: @comb.errors.full_messages, status: 406
        end
    end

    private

    def comb_params
        params.require(:comb).permit(:nectar_volume, :bee_id, :supervisor_bee_id)
    end
end
