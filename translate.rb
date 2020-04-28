require 'rest-client'
require 'json'

class Translator

    def initialize
        input
        @url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
        @key = 'trnsl.1.1.20200428T130806Z.0380fb4099ea56cd.f74b99419d7c75644fb60da9881bd0f77b4a786b'
        @text = @phrase
        @lang = "#{@init_lang}-#{@final_lang}"
        @response = translate
        create_file
    end

    def input
        print 'Enter the original language (pt, en, es, etc): '
        @init_lang = gets.chomp
        print 'Enter the language to translate to (pt, en, es, etc): '
        @final_lang = gets.chomp
        print 'Enter the text: '
        @phrase = gets.chomp
    end

    def translate
        response= RestClient.get(@url, params:{ 
            key: @key, 
            text:@text, 
            lang:@lang 
        })
        @final_phrase = JSON.parse(response)["text"]
    end

    def create_file
        time = Time.new

        file = File.open(time.strftime("%d-%m-%y_%H:%M") + ".txt", 'w') do |line|
            line.puts '---Tradução---'
            line.print "#{@init_lang}: "
            line.puts "#{@text}"
            line.print "#{@final_lang}: "
            line.puts "#{@final_phrase}"
        end
    end

end

translator = Translator.new


