require 'byebug'

get '/' do
  erb :image_upload_form
end

post '/upload_image' do
  command = "convert #{params[:image][:tempfile].path} -background white -alpha remove -alpha off bmp:- | mkbitmap -f #{params[:filter_radius]} -s 2 -t #{params[:threshold]} | convert -trim +repage pbm:- #{settings.root}/public/images/color.png"
  system(command)
  erb :show_image
end
