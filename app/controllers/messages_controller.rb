class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      # { success: 'Message が正常に投稿されました' } という形で保存
      flash[:success] = 'Message が正常に投稿されました'
      # HTTP リクエストを発生
      # message_url(@message.id)でも可 (urlは絶対パス)
      redirect_to message_url(@message.id)
    else 
      flash.now[:danger] = 'Message が投稿されませんでした'
      render new_message_path
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])

    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to message_url(@message.id)
    else 
      flash.now[:danger] = 'Message は更新されませんでした'
      redirect_to edit_message_url(@message.id)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
  end

  private
    def message_params
      params.require(:message).permit(:content)
    end
end
