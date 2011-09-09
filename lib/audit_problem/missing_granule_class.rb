class AuditProblem::MissingGranuleClass < AuditProblem::EntrySpecific
  field :granule_class, :type => String

  def self.run(options={})
    problems = []
    Entry.find_each(:conditions => "publication_date > '1995-01-01' AND (granule_class IS NULL OR granule_class NOT IN ('RULE','PRORULE','NOTICE','PRESDOCU','CORRECT','SUNSHINE'))") do |entry|
      problems << build_from_entry(entry, :granule_class => entry.granule_class)
    end
    problems
  end
end
