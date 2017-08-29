require 'open-uri'
require 'pry'

class DinoLibrary::Scraper

  def self.create_project_hash
    # write your code here
    arry = []
    doc = Nokogiri::HTML(open('https://www.thoughtco.com/dinosaurs-a-to-z-1093748'))
    projects = []
    dinosaur_id = 0
    doc.css("div#flex_1-0").each do |project|

          project.css("p").each do |dino|
            #binding.pry

            arry = dino.text.split(/\W+/)
            if dino.css("a").text == nil


                dinosaurs_name = arry[0]
                arry.shift
                dinosaurs_description = arry.join(" ")
                dinosaur_id = dinosaur_id + 1
                projects << {id: dinosaur_id, name: dinosaurs_name, description: dinosaurs_description}

            else


                dinosaurs_name = arry[0]
                arry.shift
                dinosaurs_description = arry.join(" ")
                dinosaur_id = dinosaur_id + 1
                dinosaurs_url = dino.xpath('a').map { |link| link['href'] } #get URL for attributes
                projects << {id: dinosaur_id, name: dinosaurs_name, description: dinosaurs_description, url: dinosaurs_url }

              #binding.pry
            end #if
          end #project.css
     # return the projects hash
   end#doc.css
     projects
   end #self.create_project_hash
  def self.scrape_wiki_page(wiki_url)
      doc = Nokogiri::HTML(open(wiki_url))

    	dinosaur = {}
      p = doc.css("div#mf-section-0.mf-section-0")

      dinosaur[:wiki_description] = p.css("p").text







      #  end #doc.css("table.infobox.biota")
        dinosaur
    end #scrape_wiki_page


end #end of Scraper class
