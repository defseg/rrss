require 'open-uri' # TODO: is this good practice?

class Feed < ActiveRecord::Base
  validates :url, uniqueness: { scope: :user_id }
  has_many :entries, class_name: 'Entry', dependent: :destroy

  def reload
    self.touch

    data = SimpleRSS.parse(open(self.url))
    loaded_guids = self.entries.pluck(:guid)
    # TODO: I *think* this optimizes it, but I'm not sure. should check.
    # or: use upsert? (TODO)
    Entry.transaction do
      self.entries.each do |entry|
        entry.seen = true
        entry.save!
      end

      data.entries.each do |entry_data|
        puts entry_data[:pubDate]
        unless loaded_guids.include?(entry_data.guid)
          # this makes a separate query for each new post.
          Entry.create_from_data!(entry_data, self)
        end
      end
    end
  end

  def get_title
    data = SimpleRSS.parse(open(self.url))
    data.title
  end

  def get_title!
    data = SimpleRSS.parse(open(self.url))
    self.title = data.title
    self.save
  end
end
