module API
  module V1
    class BooksController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_book, only: %i[ show update destroy ]

      # GET /books
      def index
        @books = current_user.books.all

        render json: @books
      end

      # GET /books/1
      def show
        render json: @book
      end

      # POST /books
      def create
        @book = current_user.books.build(book_params)

        if @book.save
          render json: @book, status: :created, location: @book
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /books/1
      def update
        if @book.update(book_params)
          render json: @book
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      # DELETE /books/1
      def destroy
        @book.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_book
          @book = current_user.books.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def book_params
          params.require(:book).permit(:title, :year, :artist_id)
        end
      end
  end
end
