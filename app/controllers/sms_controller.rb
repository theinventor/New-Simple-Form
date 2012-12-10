class SmsController < ApplicationController

  def create
    @posts = Post.all    #hack to make index work ;)

    @sms = Smser.new params[:smser]
    if @sms.save
      @sms.send_sms
      redirect_to root_path, notice: "Message sent!"
    else
      render 'posts/index'
    end
  end


end