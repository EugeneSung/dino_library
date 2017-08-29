
#our CLI controller
require 'nokogiri'
require 'colorize'


class DinoLibrary::CLI
  BASE_URL = 'https://en.m.wikipedia.org/wiki/'

  def call
    puts puts "Welcome to Dinosaurs Library"
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
      temp_arry = dinosaur.description.split("")

      if dinosaur.name.length < 2
        puts "============================================================================".colorize(:yellow)
        puts "#{dinosaur.name.upcase}".colorize(:red)

      elsif dinosaur.name.length > 2 && temp_arry[0].upcase == temp_arry[0]

        puts "ID: #{dinosaur.id} - #{dinosaur.name.upcase}".colorize(:red)
        puts "description: ".colorize(:light_blue) + "#{dinosaur.description}"
        if !dinosaur.url.empty?
          puts "URL:".colorize(:light_blue) + "#{dinosaur.url}"
          #binding.pry
        end
      end
    end
    want_to_see_one
  end
  def start_with_display
    puts "Please choose a letter(A-Z):"
    input = gets.strip

    DinoLibrary::Dinosaur.all.each do |dinosaur|
      letters = []
      letters = dinosaur.name.split("")
      letter = letters[0]
      temp_arry = dinosaur.description.split("")


      if input.upcase == letter || input.downcase == letter
        if dinosaur.name.length < 2
          puts "Start with #{dinosaur.name.upcase}".colorize(:red)

        elsif dinosaur.name.length > 2 && temp_arry[0].upcase == temp_arry[0]



        puts "ID: #{dinosaur.id} - #{dinosaur.name.upcase}".colorize(:red)
        puts "description: ".colorize(:light_blue) + "#{dinosaur.description}"
        puts "URL:".colorize(:light_blue) + "#{dinosaur.url}" unless dinosaur.url.empty?

        end
     end
    end
    want_to_see_one
  end

  def want_to_see_one

      input = " "
      until input.downcase == "no"
          puts "---------------------------------------------------------------------------------------------------".colorize(:green)
          puts "If you want to see more details of the dinosaur, type Dinosaur ID(type 'no' to return to main menu)"
          puts ">>"
          input = gets.strip

          dinosaur = DinoLibrary::Dinosaur.all.detect{|dino| dino.id == input.to_i}
          #binding.pry
          if dinosaur != nil && dinosaur.name.length > 2
            add_attributes_to_dinosaur(dinosaur)

            puts "---------------------------------------------------------------------------------------------------".colorize(:green)
            puts "ID: #{dinosaur.id}: #{dinosaur.name.upcase}".colorize(:red)
            puts "description: ".colorize(:light_blue) + "#{dinosaur.description}"
            puts "URL:".colorize(:light_blue) + "#{dinosaur.url}" unless dinosaur.url == nil
            puts "Wikipedia Description: ".colorize(:light_blue) + "#{dinosaur.wiki_description}"

          end #dinosaur != nil && dinosaur.name.length > 2
        end #input.downcase == "no"
  end

  def add_attributes_to_dinosaur(dinosaur)

        attributes = DinoLibrary::Scraper.scrape_wiki_page(BASE_URL + dinosaur.name)
        #binding.pry
        dinosaur.add_dinosaur_attributes(attributes)

  end
def goodbye
  puts "Thank you for using Dinosaur Library."
  puts "Good bye."

end




end
