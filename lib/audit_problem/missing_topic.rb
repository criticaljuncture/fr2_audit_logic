class AuditProblem::MissingTopic < AuditProblem::Base
  field :publication_date, :type => Date
  field :entries_with_topics_count, :type => Integer
  def self.run(options={})
    problems = []
    Entry.find_by_sql("select count(*) AS num_entries_with_topics, entries.publication_date
from entries
join topic_assignments ON topic_assignments.entry_id = entries.id
group by entries.publication_date
having num_entries_with_topics < 10").each do |result|
      problems << new(:publication_date => result.publication_date, :entries_with_topics_count => result.num_entries_with_topics)
    end
    problems
  end
end
