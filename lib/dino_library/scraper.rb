require 'open-uri'
require 'pry'

class DinoLibrary::Scraper

  def self.create_project_hash
    # write your code here

    doc = Nokogiri::HTML(open('https://www.thoughtco.com/dinosaurs-a-to-z-1093748'))
    projects = []
    doc.css("div#flex_1-0").each do |project|

          project.css("p").each do |dino|
            #binding.pry


            if dino.css("a").text == nil
              arry = dino.text.split(" ")
              dinosaurs_name = arry[0]
              arry.shift
              dinosaurs_description = arry.join(" ")
              projects << {name: dinosaurs_name, description: dinosaurs_description}
            else

              dinosaurs_url = dino.xpath('a').map { |link| link['href'] } #get URL for attributes

              #puts dinosaurs_url
              arry = dino.text.split(" ")
              dinosaurs_name = arry[0]
              arry.shift
              dinosaurs_description = arry.join(" ")
              projects << {name: dinosaurs_name, description: dinosaurs_description, url: dinosaurs_url }
            #  binding.pry
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
