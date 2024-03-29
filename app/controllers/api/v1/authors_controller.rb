module API
  module V1
    class AuthorsController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index]
      before_action :set_author, only: %i[ show update destroy ]

      def index
        @authors = Author.all

        render json: @authors
      end

      def show
        render json: @author
      end

      def create
        # TODO: update to current user
        @author = Author.new(author_params)

        if @author.save
          render json: @author, status: :created, location: @author
        else
          render json: @author.errors, status: :unprocessable_entity
        end
      end

      def update
        if @author.update(author_params)
          render json: @author
        else
          render json: @author.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @author.destroy
      end

      private
        def set_author
          # TODO: update to current user
          @author = Author.find(params[:id])
        end

        def author_params
          params.require(:author).permit(:name, :user_id)
        end
    end
  end
end