module HelenaAdministration
  module ApplicationHelper
    def title(page_title)
      content_for :title, page_title.to_s
      page_title
    end

    # adds ... in between like if you have to long names in apple finder so you can i.e see the beginning and the suffix
    def truncate_between(str, after = 30)
      str = '' if str.nil?
      str.length > after ? "#{str[0..(after / 2) - 2]}...#{str[(str.length - ((after / 2) - 2))..str.length]}" : str
    end
  end
end
