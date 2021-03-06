# README

Rails Pods API - Pods CRUD:

1. Add a teams(pods) resource in the routes.rb file like so:

Rails.application.routes.draw do
  resources :employees, teams
end

Running rails routes, will now show that we have defined routes for the teams resource, using all the standard RESTful actions, such as index, create, show, update and destroy.

2. Now, we need to define a Teams controller class that will contain the methods for our RESTful actions.

Run rails g controller Teams

3. Open app/controllers/teams_controller.rb and inside the TeamsController class, define the methods for the RESTful actions, like so:

class TeamsController < ApplicationController
  def index
    teams = Team.order("created_at DESC")
    render json: { status: "SUCCESS", message: "Loaded teams", data: teams }, status: :ok
  end

  def show
    team = Team.find(params[:id])
    render json: { status: "SUCCESS", message: "Loaded team", data: team }, status: :ok
  end

  def create
    team = team.new(team_params)

    if team.save
      render json: { status: "SUCCESS", message: "Saved team", data: team }, status: :ok
    else
      render json: { status: "ERROR", message: "team not saved", data: team.errors }, status: :unprocessable_entity
    end
  end

  def update
    team = Team.find(params[:id])
    if team.update_attributes(team_params)
      render json: { status: "SUCCESS", message: "Updated team", data: team }, status: :ok
    else
      render json: { status: "ERROR", message: "team not updated", data: team.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    team = Team.find(params[:id])
    team.destroy
    render json: { status: "SUCCESS", message: "Deleted team", data: team }, status: :ok
  end

  private

  def team_params
    params.permit(:name, :lead, :active)
  end
end
