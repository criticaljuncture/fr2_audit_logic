class AuditProblem::MissingBulkdataFile < AuditProblem::Base
  field :publication_date, :type => Date

  def self.run(options = {})
    problems = []
    (Date.parse('2000-01-01')..Date.current).each do |date|
      if Issue.should_have_an_issue?(date) && ! bulkdata_available?(date)              
        problems << new(:publication_date => date)
      end
    end
    problems
  end

  private

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
