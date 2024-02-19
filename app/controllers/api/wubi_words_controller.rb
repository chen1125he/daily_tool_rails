# frozen_string_literal: true

class Api::WubiWordsController < Api::ApplicationController
  before_action :set_wubi_word, only: %i[show update]

  def index; end

  def create
    @wubi_word = WubiWord.new(wubi_word_params)
    @wubi_word.save!

    render :show
  end

  def show; end

  def update; end

  private

  def set_wubi_word
    @wubi_word = WubiWord.find(params[:id])
  end

  def wubi_word_params
    params.permit(:word, :code, :context)
  end
end
