class Audit
  include Mongoid::Document
  
  field :started_at,      :type => DateTime
  field :completed_at,    :type => DateTime
  field :options,         :type => Hash
  field :type,            :type => String
  field :problem_counts_by_year,  :type => Hash

  embeds_many :audit_problems, :class_name => "AuditProblem::Base"

  before_save :calculate_problem_counts_by_year

  def self.using_object_ids?
    false
  end

  private

  def calculate_problem_counts_by_year
    counts = {}
    (1994..Date.current.year).each do |year|
      counts[year] = 0
    end

    audit_problems.map(&:publication_date).each do |date| 
      counts[date.year] += 1
    end

    self.problem_counts_by_year = counts
  end
end
