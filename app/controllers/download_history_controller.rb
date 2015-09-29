class DownloadHistoryController < ApplicationController
  before_filter :check_ability

  def show
    @attachment = Attachment.find(params[:attachment_id])
    @histories = DownloadHistory.where(attachment_id: @attachment.id)

    respond_to do |format|
      format.csv do
        send_data(
          csv_for(@histories),
          type: 'text/csv; header=present',
          filename: "Download History - #{Time.now.strftime("%Y-%m-%d")} - #{@attachment.filename}"
        )
      end
      format.pdf { send_file_headers! type: 'application/pdf', filename: 'issues.pdf' }
      format.html
    end
  end

  private

  def csv_for(histories)
    export = CSV.generate(col_sep: l(:general_csv_separator)) do |csv|
      # csv header fields
      csv << %w(Login Date)
      # csv lines
      @histories.each do |history|
        csv << [history.user.login, format_time(history.created_at)]
      end
    end
  end

  def check_ability
    render_404 unless User.current.allowed_to?(:view_attachment_history, nil, global: true)
  end

end
