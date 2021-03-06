class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fogend

  # Process files as they are uploaded:
  # process resize_to_fit: [800, 800]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :profile do
    process resize_to_fit: [480, 360]
  end

  version :ilustration do
    process resize_to_fit: [360, 240]
  end

  version :small do
    process resize_to_fit: [160, 120]
  end

  version :thumb do
    process resize_to_fit: [96, 96]
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  #

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end

# - deixe o imagemagick fermentando
# - inclua mini-magick
# - reduza o tamanho da imagem antes de continuar - 800 x 800
# - crie um thumb da mesma imagem - 96 x 96
# - crie um profile da mesma imagem - 360 x 360
# - crie um small da mesma imagem - 240 x 240
# - redefina o diretório para guardar imagens
# - tente pegar a imagem profile, se existir, senão, tente a imagem normal
