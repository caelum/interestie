class InterestsController < ApplicationController
  def create
    if Interest.create params[:interest]
      render text: "#{params[:callback]}({ ok : 'ok'});"
    else
      render text: "#{params[:callback]}( errors : 'unable to set up interest' );"
    end
  end
end
