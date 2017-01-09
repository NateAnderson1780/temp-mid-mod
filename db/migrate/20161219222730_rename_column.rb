class RenameColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :links, :url, :url_link
  end
end
