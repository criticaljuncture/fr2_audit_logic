class AuditProblem::BulkdataElementTooLarge < AuditProblem::EntrySpecific
  field :element_size, :type => Integer

  def self.run(options = {})
    problems = []
    Entry.find_as_array(:select => "distinct(publication_date) AS publication_date",
                        :conditions => "publication_date IS NOT NULL AND publication_date > '2000-01-01'",
                        :order => "publication_date DESC").each do |publication_date|
      entries = Entry.published_on(publication_date)
      entries.each do |entry|
        path = entry.full_xml_file_path
        if File.exists?(path)
          doc = Nokogiri::XML(open(path))
          element_size = doc.css(element).first.try(:to_s).try(:size)
          if element_size && element_size > max_element_size
            problems << build_from_entry(entry, :element_size => element_size)
          end
        end
      end
    end
    problems
  end 
end
