if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

  PictureUploader

  CarrierWave::Uploader::Base.descendants.each do |u|
    next if u.anonymous?
    u.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end
