require 'open-uri' # TODO: is this good practice?

class Feed < ActiveRecord::Base
  validates :url, uniqueness: { scope: :user_id }
  has_many :entries, class_name: 'Entry'

  def reload
    self.touch

    data = SimpleRSS.parse(open(self.url))
    loaded_guids = self.entries.pluck(:guid)
    data.entries.each do |entry_data|
      unless loaded_guids.include?(entry_data.guid)
        # this makes a separate query for each new post.
        # TODO: can this be optimized?
        Entry.create_from_data!(entry_data, self)
      end
    end
  end
end
