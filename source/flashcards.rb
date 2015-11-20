require 'csv'

class Flashcards
  attr_reader :question, :answer

  def initialize(args = {})
    @question = args[:question]
    @answer = args[:answer]
  end
end

class ArtificialIntelligence
  def initialize(deck)
    @view = View.new
    @deck = deck
    check

  end

  def check

    input = ""
    incorrect_answer = []
    @view.display_instruction
    @deck.each do |card|
      # counter = 0
      # until counter == @deck.length
      # counter += 1

      puts card.question
      input = @view.get_input
      if input.downcase == card.answer.downcase
        @view.correct

      else
        @view.incorrect
        incorrect_answer << card.question
      end

    end
    @view.list_incorrect(incorrect_answer)
  end


end


class Controller
  def initialize(args)

  end


end

class View

  def display_instruction
    puts "Please answer each question with true or false."
  end

  # def display_question

  # end

  def correct
    puts "You are correct"
  end

   def incorrect
    puts "Sorry you are incorrect :( "
  end

  def get_input
    gets.chomp
  end

  def list_incorrect(incorrect_answer)
    puts "Here is the list of incorrect responses: "
    incorrect_answer.each do |incorrect|
      puts incorrect
    end
  end

end


module Parser
  def self.create_deck(file)
    deck = []
    CSV.foreach(file, :headers => true, :header_converters => :symbol).each do |row|
     deck << Flashcards.new(row)
     end
     ArtificialIntelligence.new(deck)
  end
end





test = Parser.create_deck('deck.csv')

test
# first_card = test.each { |card| p card.answer}


