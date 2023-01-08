class ApartmentsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        apartments = Apartment.all
        render json: apartments, status: 200
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: 200
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: 201
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
        render json: apartment, status: 201
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private

    def render_not_found_response
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end

    def apartment_params
        params.permit(:number)
    end

end
