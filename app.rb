require 'byebug'

get '/' do
  @threshold_values = [0.45, 0.455, 0.460, 0.465, 0.470, 0.475, 0.480, 0.485, 0.490, 0.495, 0.499, 0.4995, 0.4999]
  @filter_radius_values = (1..10).to_a
  erb :image_upload_form
end

post '/upload_image' do

  image_file = params[:image]
  unless image_file
    return "No image selected"
  end
  image_path = params[:image][:tempfile].path

  threshold = params[:threshold].to_f
  unless threshold >= 0.45 && threshold <= 0.4999
    return "Invalid threshold (should be between 0.45 and 0.4999)"
  end

  filter_radius = params[:filter_radius].to_i
  unless filter_radius >= 1 && filter_radius <= 10
    return "Invalid filter radius (should be between 1 and 10"
  end

  command = "convert #{image_path} -background white -alpha remove -alpha off bmp:- | mkbitmap -f #{filter_radius} -s 2 -t #{threshold} | convert -trim +repage pbm:- /tmp/color.png"
  system(command)

  send_file '/tmp/color.png', :type => :png
end
