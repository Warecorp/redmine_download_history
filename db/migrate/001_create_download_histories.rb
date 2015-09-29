class CreateDownloadHistories < ActiveRecord::Migration
  def change
    create_table :download_histories do |t|
      t.integer :user_id
      t.integer :attachment_id

      t.timestamps
    end
  end
end
