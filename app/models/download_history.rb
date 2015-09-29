class DownloadHistory < ActiveRecord::Base
  belongs_to :attachment
  belongs_to :user

  def self.to_csv
    attributes = %w(Login Date)

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end
end
