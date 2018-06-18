require 'pry'

module Players
  class Computer < Player
    # SOME NOT YET IMPLEMENTED: 
      
    # ORDER OF RULES:
    # Win: if we have 2 in a row, play the 3rd to win
    # Block: if opponent has 2 in a row, play the 3rd to block 
    # Fork: if opportunity to create a fork (2 opportunites to win)
    # Block Fork: if opponent has opportunity to fork, play to block 
    # Center: play center position if available 
    # Opposite Corner: if opponent is in corner, play opposite corner
    # Empty Corner: Play empty corner position 
    # Empty Side: Play an empty side position 
    # Game Over: If none are available, game is over! 
    
    attr_accessor :opponent_token
    
    WIN_COMBINATIONS = [
      [0, 1, 2], # top row
      [3, 4, 5], # middle row
      [6, 7, 8], # bottom row
      [0, 3, 6], # left column
      [1, 4, 7], # middle column
      [2, 5, 8], # right column
      [0, 4, 8], # diagonal 1
      [2, 4, 6]  # diagonal 2
    ]
    
    FORK_COMBINATIONS = [
      [0, 2, 4],
      [0, 4, 6],
      [2, 4, 8],
      [6, 4, 8]
    ]
    
    def opponent_token
      if @token == "O"
        @opponent_token = "X"
      else 
        @opponent_token = "O"
      end 
    end 
    
    def can_we_win?(board)
      WIN_COMBINATIONS.detect do |combination|
        position_1 = board.cells[combination[0]]
        position_2 = board.cells[combination[1]]
        position_3 = board.cells[combination[2]]

        [position_1, position_2, position_3].count(@token) == 2 &&
        [position_1, position_2, position_3].count(" ") == 1
      end 
    end 
    
    def play_the_win(board)
      winning_combo = can_we_win?(board)
      position = winning_combo[0] if board.valid_move?(winning_combo[0] + 1)
      position = winning_combo[1] if board.valid_move?(winning_combo[1] + 1)
      position = winning_combo[2] if board.valid_move?(winning_combo[2] + 1)
      position += 1 
      position.to_s 
    end 
    
    def can_they_win?(board)
      WIN_COMBINATIONS.detect do |combination|
        
        if board.cells[6] == "O"
          binding.pry 
        end 
        
        position_1 = board.cells[combination[0]]
        position_2 = board.cells[combination[1]]
        position_3 = board.cells[combination[2]]
        binding.pry 
        [position_1, position_2, position_3].count(@opponent_token) == 2 &&
        [position_1, position_2, position_3].count(" ") == 1
      end 
    end 
    
    def block_the_win(board)
      winning_combo = can_they_win?(board)
      
      position = winning_combo[0] if board.valid_move?(winning_combo[0] + 1)
      position = winning_combo[1] if board.valid_move?(winning_combo[1] + 1)
      position = winning_combo[2] if board.valid_move?(winning_combo[2] + 1)
      position += 1 
      position.to_s
    end 
    
    def can_we_fork?(board)
      FORK_COMBINATIONS.detect do |combination|
        position_1 = board.cells[combination[0]]
        position_2 = board.cells[combination[1]]
        position_3 = board.cells[combination[2]]

        [position_1, position_2, position_3].count(@token) == 2 &&
        [position_1, position_2, position_3].count(" ") == 1
      end 
    end 
    
    def play_the_fork(board)
      winning_combo = can_we_fork?(board)

      position = winning_combo[0] if board.valid_move?(winning_combo[0] + 1)
      position = winning_combo[1] if board.valid_move?(winning_combo[1] + 1)
      position = winning_combo[2] if board.valid_move?(winning_combo[2] + 1)
      position += 1 
      position.to_s 
    end 
    
    def block_fork(board)
    end 
    
    def center(board)
      "5" if board.cells[4] == " "
    end 
    
    def opposite_corner(board)
    end 
    
    def empty_corner(board)
      position = nil 
      
      if board.cells[0] == " "
        position = "1" 
      elsif board.cells[2] == " "
        position = "3" 
      elsif board.cells[6] == " "
        position = "7" 
      elsif board.cells[8] == " " 
        position = "9" 
      end 
      position 
    end 
    
    def empty_side(board)
    end 
    
    def move(board)
      position = nil 

      if can_we_win?(board)
        position = play_the_win(board)
      elsif can_they_win?(board)
        position = block_the_win(board)
      elsif can_we_fork?(board)
        position = play_the_fork(board)
      elsif center(board)
        position = center(board)
      elsif empty_corner(board)
        # FIX ME
        position = empty_corner(board)
        
      # FIRST AVAILABLE EMPTY POSITION: 
      elsif board.cells.index(" ")
        position = board.cells.index(" ") + 1 
      else 
        nil 
      end 
      position.to_s 
    end 
    
  end 
end 