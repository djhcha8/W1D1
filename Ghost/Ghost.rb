class Ghost

  attr_reader :player_one, :player_two


  def initialize(players, fragment = "", dictionary = File.readlines('dictionary.txt'))
    @player_one = Player.new(players[0])
    @player_two = Player.new(players[1])
    @fragment = fragment
    @dictionary = dictionary
  end

  def current_player
    @current_player = @player_one
    @current_player
  end

  def previous_player
    if current_player == @player_one
      return @player_two
    else
      return @player_one
    end
  end

  def next_player!
    if current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end

  def play_turn(current_player)
    begin
      p "Which letter would you like to add?"
      guess = gets.chomp
      temp = fragment.dup += guess
      if valid_play?(fragment) == false
        p "Invalid move!!"
      end
    rescue
      fragment += guess
    end
  end

  def valid_play?(fragment)
    return true if dictionary.any?{|el| el.starts_with?(fragment)}
    false

  end

  def loss?(fragment)
    return true if dictionary.include?(fragment)
    false
  end

  def play_round
    game_status = false

    until game_status
      self.play_turn(current_player)
      if self.loss?(fragment)
        p "#{@current_player} has lost"
        @current_player << GHOST.shift
        self.next_player!
      end

    end

  end

end #Class

class Player
  def initialize(name)
    @name = name
    @ghost = ""
  end

  GHOST = ['g', 'h', 'o', 's', 't']

end


# game = Ghost.new(['Ian', "David"], "", File.readlines("dictionary.txt"))
