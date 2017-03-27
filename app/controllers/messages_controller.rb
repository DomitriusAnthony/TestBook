class MessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    @message = @conversation.messages.create(message_params)

    message = Message.new(message_params)
    message.user = current_user
    if @message.save
      ActionCable.server.broadcast 'messages',
        message: message.content,
          user: message.user.email
            head :ok
    end
    
    respond_to do |format|
      format.js
    end
  end



  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end