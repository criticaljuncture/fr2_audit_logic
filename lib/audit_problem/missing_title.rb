class AuditProblem::MissingTitle < AuditProblem::EntrySpecific
  def self.run(options={})
    problems = []
    Entry.find_each(:conditions => "title IS NULL or title = ''") do |entry|
      problems << build_from_entry(entry)
    end
    problems
  end
end
