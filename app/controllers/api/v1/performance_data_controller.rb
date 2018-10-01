class Api::V1::PerformanceDataController < ApplicationController
	before_action :authenticate_api_v1_user!

	def create
		@data = PerformanceData.new(performance_data_params)
		
		@data.user_id = current_api_v1_user.id

    if @data.save
      render json: { message: 'all good' }
    else
      render json: { error: @data.errors.full_messages }
    end
  end

  private

  def performance_data_params
    params.require(:performance_data).permit!
  end
end