class AuditProblem::MissingAgency < AuditProblem::EntrySpecific
  def self.run(options={})
    field :agency_names, :type => String

    problems = []
    Entry.find_each(:joins => "JOIN agency_name_assignments ON agency_name_assignments.assignable_id = entries.id AND agency_name_assignments.assignable_type = 'Entry' LEFT OUTER JOIN agency_assignments ON agency_assignments.assignable_id = entries.id AND agency_assignments.assignable_type = 'Entry'", :conditions => "agency_assignments.id IS NULL") do |entry|
      problems << build_from_entry(entry, :agency_names => entry.agency_names.map(&:name).to_sentence)
    end
    problems
  end
end
