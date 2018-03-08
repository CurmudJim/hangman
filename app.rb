require 'sinatra'
require 'sinatra/reloader' if development?
enable :sessions

LIBRARY = ["Awkward", "Bagpipes", "Banjo", "Bungler", "Croquet", "Crypt", "Dwarves", "Fervid", "Fishhook", "Fjord", "Gazebo", "Gypsy", "Haiku", "Haphazard", "Hyphen", "Ivory", "Jazzy", "Jiffy", "Jinx", "Jukebox", "Kayak", "Kiosk", "Klutz", "Memento", "Mystify", "Numbskull", "Ostracize", "Oxygen", "Pajama", "Phlegm", "Pixel", "Polka", "Quad", "Quip", "Rhythmic", "Rogue", "Sphinx", "Squawk", "Swivel", "Toady", "Twelfth", "Unzip", "Waxy", "Wildebeest", "Yacht", "Zealous", "Zigzag", "Zippy", "Zombie"]
WORD = LIBRARY[rand(LIBRARY.length)].downcase
@@wordArr = WORD.split("").to_enum(:each_with_index).map{|a,i| [a , i] }
@@result = @@wordArr.map { |x| x = "_" }.join("")
@@tries = 6
@@letters = []



get '/' do
  letter = params['letter']
  if !letter.nil?
    if letter.length > 1 || @@letters.include?(letter)
      @message = "Invalid input."
    else
      @@letters.push(letter)

      @@wordArr.each { |i|
        if i[0] == letter
          @@result[i[1]] = letter
        end
      }

      if !@@result.include?(letter)
        @@tries -= 1
      end

      if params['reset'] || @@tries == 0 || WORD == @@result
        if @@tries == 0
          @message = "Try Again!"
        elsif WORD == @@result
          @message = "You Won!"
        end
        WORD = LIBRARY[rand(LIBRARY.length)].downcase
        @@wordArr = WORD.split("").to_enum(:each_with_index).map{|a,i| [a , i] }
        @@result = @@wordArr.map { |x| x = "_" }.join("")
        @@tries = 6
        @@letters = []
      end
    end
  end

  if params['cheat'] == "Cheat"
    @message = "The answer is \"#{WORD}\", CHEATER!"
  end
  erb :index
end
