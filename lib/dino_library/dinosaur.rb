class DinoLibrary::Dinosaur

  attr_accessor :name, :description, :phylum,:clade, :kingdom, :url, :wiki_description

  @@all = []

 def initialize(dinosaurs_hash)
   dinosaurs_hash.each do |key, value|
     self.send("#{key}=", value)
   end
   @@all << self
 end

 def self.create_from_collection(dinosaurs_array)
   dinosaurs_array.each do |dinosaurs|
     DinoLibrary::Dinosaur.new(dinosaurs)
   end
 end
 def add_dinosaur_attributes(attributes_hash)

   unless attributes_hash == nil
     attributes_hash.each do |key, value|
       self.send("#{key}=", value)
     end
   end
 end

 def self.all
   @@all
 end


end
