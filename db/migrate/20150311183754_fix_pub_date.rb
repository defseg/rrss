class FixPubDate < ActiveRecord::Migration
  def change
    remove_column :entries, :pubDate, :datetime
    add_column :entries, :pub_date, :datetime
  end
end
