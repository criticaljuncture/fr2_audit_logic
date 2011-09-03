module AuditProblem
  class Base
    include Mongoid::Document
    field :_id, :type => BSON::ObjectId
    embedded_in :audit, :inverse_of => :audit_problems

    def self.perform(options = {})
      audit = Audit.new(:type => self.to_s)
      audit.started_at   = Time.now
      audit.audit_problems     = run(options)
      audit.completed_at = Time.now
      audit.save!
    end
    
    def self.run(options = {})
    end

    def self.date_range
      Date.parse('1994-01-01') .. Date.current
    end

    def self.using_object_ids?
      false
    end
  end
end
