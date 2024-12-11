class EventsController < ApplicationController
  before_action :set_event, only: %i[ show update destroy ]

  # GET /events
  def index
    if params[:user_id] && params[:available_with_user_id].present?
      events = ::EventServices::GetAvailable.new
      response = events.perform({
        available_with_user_id: params[:available_with_user_id],
        user_id: params[:user_id],
      })

      @events = response
    elsif params[:user_id]
      @events = Event.where(user_id: params[:user_id])
    else
      @events = Event.all
    end

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.expect(event: [ :id, :name, :start, :end, :user_id ])
    end

    def filter_params
      params.permit(:user_id, :available_with_user_id)
    end
end
