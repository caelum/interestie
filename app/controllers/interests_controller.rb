class InterestsController < ApplicationController
  def create
    interest = Interest.create params[:interest]
    if interest.valid?
      render text: "#{params[:callback]}({ ok : 'ok'});"
    else
      render text: "#{params[:callback]}({ errors : 'unable to set up interest' });"
    end
  end
end
