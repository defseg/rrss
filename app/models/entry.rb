class Entry < ActiveRecord::Base
  belongs_to :feed

  def self.create_from_data!(entry_data, feed)
    entry_data = self.filter(entry_data)
    entry_data[:feed_id] = feed.id
    self.create!(entry_data)
  end

  def self.filter(data)
    {
      title:           data[:title],
      link:            data[:link],
      description:     data[:description],
      pubDate:         data[:pubDate],
      content_encoded: data[:content_encoded],
      category:        data[:category],
      dc_creator:      data[:dc_creator],
      guid:            data[:guid]
    }
  end

end
