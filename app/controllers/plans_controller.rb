class PlansController < ApplicationController
  def index
    plans = Plan.all
    build_response(plans, 200)
  end

  def create
    plans = Plan.where(title: params[:title])
    return build_response('already exists', 422) if plans.any?

    plan = Plan.new(plan_params)
    return build_response('Is Invalid', 422) unless plan.valid?

    plan.save
    build_response(plan, 200)
  end

  def show
    plan = Plan.where(id: params[:id])
    build_response(plan.as_json, 200)
  end

  def update
    plan = Plan.where(id: params['id']).last
    return build_response('not found', 404) if plan.nil?

    plan.update(plan_params)
    return build_response('Is Invalid', 422) unless plan.valid?

    build_response(plan, 200)
  end

  def destroy
    plan = Plan.where(id: params['id']).last
    return build_response('not found', 404) if plan.nil?

    plan.destroy

    build_response(plan, 204)
  end

  private

  def plan_params
    { title: params[:title], active: params[:active] }
  end
end
