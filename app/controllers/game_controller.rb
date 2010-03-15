class GameController < ApplicationController
  
  before_filter :validate_user, :except => ['user','reset_all']
  
  layout 'game'
  
  def index
    @room = @player.location
    @everyone = @room.everyone
  end
  
  def user
    if request.post?
      @player = Player.play(params[:player][:name],params[:player][:occupation])
      if !@player.new_record?
        session[:player] = @player.id
        redirect_to :action => 'index'
      end
    end
    @player = Player.new(params[:player])
  end
  
  def reset_all
    Player.destroy_all
    redirect_to :action => 'user'
  end

  def move
    @room = @player.location
    if !@player.valid_move?(params[:diffy],params[:diffx]) 
      final_move = {}
    else
      final_move = @room.generate_move(@player,params[:diffy].to_i,params[:diffx].to_i)
      Juggernaut.send_to_all("Smorpglish.animateTo('#{@player.id}',#{final_move.to_json});")
    end
    render :json => final_move

  end

  protected
  
  def validate_user
    if session[:player]
      @player = Player.find(session[:player])
    end
    if !(@player && @player.location.is_a?(Location))
      session[:player] = nil
      redirect_to :action => 'user'
    end

  end

end
