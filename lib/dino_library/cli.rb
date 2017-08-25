
#our CLI controller
require 'nokogiri'
require 'colorize'


class DinoLibrary::CLI
  BASE_URL = 'https://en.m.wikipedia.org/wiki/'

  def call
    puts puts "Welcome to Dinosaurs Dic"
    make_dinosaurs
    run
    goodbye
  end
  def run
    input = " "

    until input.downcase == "exit"
      puts "--------------------------------------------------------------".colorize(:yellow)
      puts "Which Dinosaur you are looking for?"
      puts "To see all of dinosaurs from A to Z, enter 'all'."
      puts "To see dinosaurs start with a specific letter, enter 'letter'."
      puts "To see one specific dinosaur, enter 'one'"
      puts "To quit, enter 'exit':"
      puts ">>"
      input = gets.strip

      case
      when input.downcase == 'all'
        display_dinosaurs
      when input.downcase == "letter"
        start_with_display
      when input.downcase ==  "one"
        display_one
      else
        puts "Type 'all', 'letter', or 'one'" unless input.downcase == 'exit'
      end #case
  end#until



  end

  def make_dinosaurs
    dinosaurs_array = DinoLibrary::Scraper.create_project_hash
    DinoLibrary::Dinosaur.create_from_collection(dinosaurs_array)

  end

  def display_dinosaurs


    DinoLibrary::Dinosaur.all.each do |dinosaur|
      if dinosaur.name.length < 2
        puts "============================================================================".colorize(:yellow)
        puts "#{dinosaur.name.upcase}".colorize(:red)

      elsif dinosaur.name.length > 2

        puts "#{dinosaur.name.upcase}".colorize(:red)
        puts "description: ".colorize(:light_blue) + "#{dinosaur.description}"
        puts "URL:".colorize(:light_blue) + "#{dinosaur.url}"

      end
    end

  end
  def start_with_display
    puts "Please choose a letter(A-Z):"
    input = gets.strip

    DinoLibrary::Dinosaur.all.each do |dinosaur|
      letters = []
      letters = dinosaur.name.split("")
      letter = letters[0]


      if input.upcase == letter || input.downcase == letter
        if dinosaur.name.length < 2
          puts "Start with #{dinosaur.name.upcase}".colorize(:red)

        elsif dinosaur.name.length > 2



        puts "#{dinosaur.name.upcase}".colorize(:red)
        puts "description: ".colorize(:light_blue) + "#{dinosaur.description}"
          puts "URL:".colorize(:light_blue) + "#{dinosaur.url}"

      end
    end
    end
  end
  def display_one
    puts "Please choose a name of dinosaurs:"
    input = gets.strip

    dinosaur = DinoLibrary::Dinosaur.all.detect{|dino| dino.name.downcase == input.downcase}
    #binding.pry
    if dinosaur != nil && dinosaur.name.length > 2
      add_attributes_to_dinosaur(dinosaur)

      puts "----------------------------------------------------------------------------".colorize(:green)
      puts "#{dinosaur.name.upcase}".colorize(:red)
      puts "description: ".colorize(:light_blue) + "#{dinosaur.description}"
      puts "URL:".colorize(:light_blue) + "#{dinosaur.url}"
      puts "Wikipedia Description: ".colorize(:light_blue) + "#{dinosaur.wiki_description}"

    else
      display_one
    end



  end
  def add_attributes_to_dinosaur(dinosaur)

        attributes = DinoLibrary::Scraper.scrape_wiki_page(BASE_URL + dinosaur.name)
        #binding.pry
        dinosaur.add_dinosaur_attributes(attributes)

  end
def goodbye
  puts "Thank you for using Dinosaur Dic."
  puts "Good bye."

end




end
