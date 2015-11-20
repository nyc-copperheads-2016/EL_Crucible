require 'csv'
require 'pry'

class Flashcards
  attr_reader :question, :answer

  def initialize(args = {})
    @question = args[:question]
    @answer = args[:answer]
  end
end

class ArtificialIntelligence
  attr_accessor :incorrect_answer

  def initialize
    @view = View.new
    @incorrect_answer = []
  end

  def check(card, guess)
    # guess = ""
    if guess.downcase == card.answer.downcase
      @view.correct
    else
      @view.incorrect
      @incorrect_answer << card.question
    end
    # sleep 3
  end
end


class Controller

  attr_reader :ai, :view

  def initialize(filename)
    @ai = ArtificialIntelligence.new
    @view = View.new
    # view.display_instruction
    deck_loader(filename)

  end

  def deck_loader(deck_choice)
    deck = Parser.create_deck(deck_choice)
    run(deck)
  end

  def run(deck)

    # binding.pry
    view.display_instruction
    deck.each do |card|
      # binding.pry
      guess =""
      puts card.question
      guess = view.get_guess
      # binding.pry
      ai.check(card, guess)
    end
    view.list_incorrect(ai.incorrect_answer)

  end
end

class View

  def display_instruction
    puts "Please answer each question with true or false."
  end

  def correct
    puts "You are correct!"
    question_divider
  end

   def incorrect
    puts "Sorry you are incorrect :( "
    question_divider
  end

  def get_guess
    STDIN.gets.chomp
  end

  def list_incorrect(incorrect_answer)
    question_divider
    puts "Here is the list of incorrect responses: "
    incorrect_answer.each do |incorrect|
      puts incorrect
    end
  end

  def question_divider
    puts "========================================"
  end
end


module Parser
  def self.create_deck(file)
    deck = []
    CSV.foreach(file, :headers => true, :header_converters => :symbol).each do |row|
     deck << Flashcards.new(row)
     end
     deck
  end
end





# test = Parser.create_deck('deck.csv')
# control = Controller.new(Parser.create_deck('deck.csv'))
# control
# # first_card = test.each { |card| p card.answer}
# if ARGV[0] == "1"

test = Controller.new(ARGV[0])



