class Api::V1::SpacesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_space, only: %i[update show destroy]

  def index
    @spaces = Space.includes(:user).where(user: {role: current_user.role}).order(created_at: :desc)

    render_success('', {spaces: SpacesSerializer.new(@spaces).serializable_hash})
  end

  # GET /spaces/{id}
  def show
    render_success('',ConversationsSerializer.new(@space.conversations).serializable_hash)
  end

  def create
   @space = current_user.spaces.new(space_params)
    if @space.save
      render_success("Space was successfully created",
         SpacesSerializer.new(@space).serializable_hash)
    else
      render_errors(@space)
    end
  end

  # PUT /spaces/{id}
  def update
    if @space.update(space_params)
      render_success("Space was successfully updated")
    else
      render_errors(@space)
    end
  end

  def destroy
    if @space.destroy
      render_success("Space was successfully deleted")
    else
      render_errors(@space)
    end
  end

  private

  def find_space
    @space = Space.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'error', message: "Space couldn't found", data: {}}, status: :not_found
  end

  def space_params
    params.require(:space).permit(:name)
  end
end
