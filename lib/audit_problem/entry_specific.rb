class AuditProblem::EntrySpecific < AuditProblem::Base
  field :publication_date, :type => Date
  field :document_number, :type => String
  field :entry_id, :type => Integer

  def self.build_from_entry(entry, options = {})
    new(
      options.merge(
        :publication_date => entry.publication_date,
        :document_number => entry.document_number,
        :entry_id => entry.id
      )
    )
  end
end
