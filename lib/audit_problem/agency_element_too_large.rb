class AuditProblem::AgencyElementTooLarge < AuditProblem::BulkdataElementTooLarge
  def self.element
    'AGY'
  end

  def self.max_element_size
    500
  end
end
