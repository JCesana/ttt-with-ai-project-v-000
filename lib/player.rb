class Player
  attr_reader :token 
  
  def initialize(token)
    @token = token
    @opponent_token = find_opponent_token
  end 
  
  def find_opponent_token
    "O" if @token == "X"
    "X" if @token == "O"
  end 
end 