class DownloadHistoryController < ApplicationController
  before_action :check_ability

  def show
    @attachment = Attachment.find(params[:attachment_id])
    @histories = DownloadHistory.where(attachment_id: @attachment.id)

    respond_to do |format|
      format.pdf { send_file_headers! type: 'application/pdf', filename: 'issues.pdf' }
      format.html
    end
  end

  private

  def check_ability
    render_404 unless User.current.allowed_to?(:view_attachment_history, nil, global: true)
  end

end
