class SupervisorBeesController < ApplicationController
    def create
        @supervisor_bee = SupervisorBee.new(supervisor_bee_params)
        if @supervisor_bee.save
            @worker_bee = SupervisorBees.find(@supervisor_bee.bee_id)
            render :show
        else
            render json: @supervisor_bee.errors.full_messages, status: 406
        end
    end

    def show
        @supervisor_bee = @supervisor_bee.find(params[:bee_id])
    end
    

    def destroy
        @supervisor_bee = SupervisorBee.find(params[:id])
        if @supervisor_bee.destroy
            @SupervisorBee = SupervisorBees.find(@supervisor_bee.bee_id)
            render :show
        else
            render json: @supervisor_bee.errors.full_messages, status: 406
        end
    end

    private
    def supervisor_bee_params
        params.require(:supervisor_bee).permit(:bee_id, :comb_id, :id)
    end
end
