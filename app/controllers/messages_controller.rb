class MessagesController < ApplicationController
  # @message = Message.find(params[:id])を共通化
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all.page(params[:page]).per(3)
  end

  def show
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
      # message_url(@message.id)も可 (urlは絶対パス)
      redirect_to @message
    else 
      flash.now[:danger] = 'Message が投稿されませんでした'
      # HTTP リクエストを発生させない
      # 'new'または new_message_pathでも可
      render :new
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      # message_url(@message.id)も可
      redirect_to @message
    else 
      flash.now[:danger] = 'Message は更新されませんでした'
      # 'edit', でも可, edit_message_path(@message.id)はできなかった?
      render :edit
    end
  end

  def destroy
    @message.destroy
    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
  end
  
  private

    def set_message
      @message = Message.find(params[:id])
    end
    # Strong Parameter
    def message_params
      params.require(:message).permit(:content, :title)
    end
end
