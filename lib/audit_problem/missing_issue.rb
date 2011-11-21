class AuditProblem::MissingIssue < AuditProblem::Base
  field :publication_date, :type => Date
  field :mods_available_locally, :type => Boolean
  field :bulkdata_available, :type => Boolean

  def self.run(options = {})
    problems = []
    (Date.parse('1994-01-01')..Date.current).each do |date|
      if Issue.should_have_an_issue?(date)
        if Entry.published_on(date).count == 0
          problems << new(:publication_date => date,
                          :mods_available => mods_file_available?(date),
                          :bulkdata_available => bulkdata_available?(date))
        end
      end
    end
    problems
  end

  private

  def self.mods_file_available?(date)
    mods_file = Content::EntryImporter::ModsFile.new(date, false)
    File.delete(mods_file.file_path) if File.exists?(mods_file.file_path)
    begin
      mods_file.document
      return true
    rescue Errno::ENOENT, Content::EntryImporter::ModsFile::DownloadError
      return false
    end
  end

  def self.bulkdata_available?(date)
    bulkdata_file = Content::EntryImporter::BulkdataFile.new(date, false)
    return nil if date < Date.parse('2000-01-01')
 
    File.delete(bulkdata_file.path) if File.exists?(bulkdata_file.path)
    begin
      bulkdata_file.document
      return true
    rescue Errno::ENOENT, Content::EntryImporter::BulkdataFile::DownloadError
      return false
    end
  end

end
