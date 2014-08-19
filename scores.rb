require 'rubygems'
require 'oily_png'
require 'RMagick'
include Magick

1..10.times do |score|
  puts "Processing image #{score} ..."

  canvas = Image.new(512, 512) do |c|
    c.background_color= "Transparent"
  end

  gc = Magick::Draw.new
  gc.stroke('transparent')
  gc.fill('white')
  gc.text_align(Magick::CenterAlign)
  gc.text(256, 270, "#{score}")
  gc.font_family = 'Helvetica'
  gc.pointsize = 64

  gc.draw(canvas)
  canvas.write("scores/#{score}.png")

  background = ChunkyPNG::Image.from_file("_hextris_core.png")
  foreground = ChunkyPNG::Image.from_file("scores/#{score}.png")
  background.compose!(foreground, 0, 0)
  background.save("scores/#{score}.png", :fast_rgba)
end
