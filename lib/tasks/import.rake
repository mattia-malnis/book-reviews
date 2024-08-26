namespace :import do
  desc "Import books"
  task books: :environment do
    Rails.logger = Logger.new(STDOUT)
    Rails.logger.level = Logger::INFO

    Rails.logger.info("Starting book import")

    begin
      BookImporter.new.import
      Rails.logger.info("Book import completed successfully")
    rescue StandardError => e
      Rails.logger.error("Failed to import books: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      raise e
    end
  end
end
