class HomesController < ApplicationController
  def index
  end

  def get_suggestion
    # begin
      @suggestion = GetCorrectedText.new.call(params[:text], params[:mode])
    # rescue => e
    #   flash[:error] = e.message
    # end
  end
end
