require 'rubygems'
require 'oily_png'
require 'RMagick'

# Create HTML and PNG files representing Hextris High Scores for sharing
# on the Twitters. Results in a directory structure like this:
#
# [-] hextriscores
#     [-] images
#         [+] 0.png
#         [+] 1.png
#          .
#          .
#          .
#         [+] 9999.png
#     [-] score
#         [+] 1
#             [-] index.html
#         [+] 2
#             [-] index.html
#          .
#          .
#          .
#         [+] 9999

include Magick

begin
  Dir.mkdir "images"
  Dir.mkdir "score"
rescue
  # nada
end

1..9999.times do |score|
  puts "Processing image #{score} ..."

  # canvas = Image.new(120, 120) do |c|
  #   c.background_color= "Transparent"
  # end
  #
  # gc = Magick::Draw.new
  # gc.stroke('transparent')
  # gc.fill('white')
  # gc.text_align(Magick::CenterAlign)
  # gc.text(60, 71, "#{score}")
  # gc.font_family = 'Helvetica'
  # gc.pointsize = 20
  #
  # gc.draw(canvas)
  # canvas.write("images/#{score}.png")
  #
  # background = ChunkyPNG::Image.from_file("_hextris_core.png")
  # foreground = ChunkyPNG::Image.from_file("images/#{score}.png")
  # background.compose!(foreground, 0, 0)
  # background.save("images/#{score}.png", :fast_rgba)

  # generate redirect file
  html =  "<!DOCTYPE html>\n"
  html << "<html lang='en'>\n"
  html << "<head>\n"
  html << "<title>Hextris High Score: #{score}</title>\n"
  html << "<meta property='twitter:card' content='summary' />\n"
  html << "<meta property='twitter:site' content='@hextris' />\n"
  html << "<meta property='twitter:site:id' content='2742209678' />\n"
  html << "<meta property='twitter:creator' content='@hextris' />\n"
  html << "<meta property='twitter:creator:id' content='2742209678' />\n"
  html << "<meta property='twitter:domain' content='http://hextris.github.io' />\n"
  html << "<meta property='twitter:title' content='Hextris High Score!' />\n"
  html << "<meta property='twitter:description' content='I just scored #{score} points on Hextris, an addictive puzzle game inspired by Tetris.' />\n"
  html << "<meta property='twitter:image:src' content='http://hextris.github.io/score/images/#{score}.png' />\n"
  html << "<meta property='twitter:image:width' content='120' />\n"
  html << "<meta property='twitter:image:height' content='120' />\n"
  html << "<meta http-equiv='refresh' content='0;URL=http://hextris.github.io/hextris'>\n"
  html << "</head>\n"
  html << "</html>\n"

  # save to e.g. http://hextris.github.io/score/1337/index.html
  begin
    #File.delete "score/#{score.to_s}/index.html"
    #Dir.rmdir "score/#{score.to_s}"
    Dir.mkdir "score/#{score.to_s}"
    File.open("score/#{score}/index.html", 'w') { |file| file.write(html) }
  rescue
    # nada
  end
end
