class Audit
  include Mongoid::Document
  
  field :started_at,      :type => DateTime
  field :completed_at,    :type => DateTime
  field :options,         :type => Hash
  field :type,            :type => String

  embeds_many :audit_problems, :class_name => "AuditProblem::Base"

  def self.using_object_ids?
    false
  end
end
