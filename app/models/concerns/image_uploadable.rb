require "open-uri"

module ImageUploadable
  extend ActiveSupport::Concern

  included do
    has_one_attached :image do |attachable|
      attachable.variant :small, resize_to_limit: [ 300, 300 ]
    end
  end

  def attach_image_from_url
    return if temp_image_url.blank?

    downloaded_image = download_image_from_url
    return if downloaded_image.blank?

    image.attach(io: downloaded_image[:file], filename: downloaded_image[:name])

    update_column :temp_image_url, nil if image.attached?
  end

  private

  def download_image_from_url
    return if temp_image_url.blank?

    begin
      file = URI.open(temp_image_url)
      name = File.basename(temp_image_url)
      { file:, name: }

    rescue OpenURI::HTTPError, URI::InvalidURIError => e
      Rails.logger.error("Failed to download image from #{temp_image_url}: #{e.message}")
      nil
    end
  end
end
