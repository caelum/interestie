class InterestsController < ApplicationController
  
  def create
    interest = Interest.create params[:interest]
    msg = interest.valid? ? ok_msg : error_msg
    
    render :json => msg, :callback => params[:callback]
  end
  
  private
  def error_msg
    { 'errors' => ['unable to set up interest'] }
  end
  def ok_msg
    { 'ok' => 'ok'}
  end
end
