class AuditProblem::MissingPageRange < AuditProblem::EntrySpecific
  MIN_PAGE_RANGE = 10

  field :num_pages, :type => Integer
  field :starting_page, :type => Integer
  field :ending_page, :type => Integer

  def self.run(options = {})
    problems = []
    Entry.connection.execute("SET @prior_end_page = 0")
    entries_with_gaps = Entry.find_by_sql("
      SELECT t.*
      FROM (
	      SELECT id, publication_date, volume, document_number, @prior_end_page - 1 AS range_start, start_page - 1 AS range_end, start_page - @prior_end_page - 1 AS range_size, @prior_end_page := end_page
        FROM entries
        WHERE volume > 59
        ORDER BY volume, start_page, end_page
      ) t
      WHERE range_size >= #{MIN_PAGE_RANGE}"
    ).each do |entry|
      problems << build_from_entry(entry,
        :num_pages => entry.range_size,
        :starting_page => entry.range_start,
        :ending_page => entry.range_end
      )
    end
    problems
  end
end
