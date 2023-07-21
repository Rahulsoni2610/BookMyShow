class OwnersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  skip_before_action :customer_check
  skip_before_action :owner_check, except: [:index]

  def create
    owner = Owner.new(set_params)
    if owner.save
      render json: { message: 'Registration successful' }
    else
      render json: owner.errors.full_messages
    end
  end

  def index
    render json: @current_user
  end

  private

  def set_params
    params.permit(:name, :email, :password, :image)
  end
end
