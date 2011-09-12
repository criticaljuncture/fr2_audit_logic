class AuditProblem::InvalidDocumentNumber < AuditProblem::EntrySpecific
  def self.run(options={})
    problems = []
    Entry.find_each(:conditions => "document_number IS NULL OR document_number = '' OR document_number LIKE 'X%'") do |entry|
      problems << build_from_entry(entry)
    end
    problems
  end
end
