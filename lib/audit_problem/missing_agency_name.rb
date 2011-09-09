class AuditProblem::MissingAgencyName < AuditProblem::EntrySpecific
  def self.run(options={})
    problems = []
    Entry.find_each(:joins => "LEFT OUTER JOIN agency_name_assignments ON agency_name_assignments.assignable_id = entries.id AND agency_name_assignments.assignable_type = 'Entry'", :conditions => "agency_name_assignments.id IS NULL") do |entry|
      problems << build_from_entry(entry)
    end
    problems
  end
end
