class Api::V1::ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :custom_validations, only: :get_output
  include CheckJson

  def get_output
    user_id = current_user.id
    input = valid_json?(params[:input]) ? JSON.parse(params[:input]) : params[:input]
    begin
      client = OpenaiApi.new
      @output = client.generate_text(input, current_user)
      if @output
        find_or_create_space
        ConversationWorker.perform_async(input, @output, @space.id, user_id)
      end
      render_success('', { text: @output, space_id: @space.id, space_name: @space.name })
    rescue => e
      show_error(e.to_json)
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:input, :output, :space_id)
  end

  def custom_validations
   if check_params
     show_error(@params_output)
   end
  end

  def check_params
    @params_output = if params[:input].blank?
                        "Input field is mandatory."
                     elsif params[:space_id].present? && !Space.find(params[:space_id])
                        "Couldn't find Space with 'id'=#{params[:space_id]}"
                     end
  end

  def find_or_create_space
    @space = if params[:space_id].present?
                  Space.find(params[:space_id])
                else
                  current_user.spaces.create(name: params[:input].truncate_words(4))
                end
  end
end
