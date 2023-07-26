# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
  #   if @current_user.admin?
  #     can :manage ,  theater
  #   elsif @current_user.customer?
  #     can :show , user
  #   end
  # end
end
