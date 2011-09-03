class AuditProblem::MissingModsFile < AuditProblem::Base
  field :publication_date, :type => Date
  field :available_on_fdsys, :type => Boolean

  def self.run(options = {})
    problems = []
    (Date.parse('1994-01-01')..Date.today).each do |date|
      if Issue.should_have_an_issue?(date)
        if Entry.published_on(date).count == 0
          mods_file = Content::EntryImporter::ModsFile.new(date)
          File.delete(mods_file.file_path) if File.exists?(mods_file.file_path)
          begin
            mods_file.document
            problems << new(:publication_date => date, :available_on_fdsys => true)
          rescue Errno::ENOENT
            problems << new(:publication_date => date, :available_locally => false)
          rescue Content::EntryImporter::ModsFile::DownloadError
            problems << new(:publication_date => date, :available_on_fdsys => false)
          end
        end
      end
    end
    problems
  end
end
