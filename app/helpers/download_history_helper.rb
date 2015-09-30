module DownloadHistoryHelper

  def history_page_to_pdf(histories, attachment)
    pdf = Redmine::Export::PDF::ITCPDF.new(current_language)
    pdf.set_title("Download History - #{attachment.filename}")
    pdf.alias_nb_pages
    pdf.footer_date = format_date(Date.today)
    pdf.add_page
    pdf.SetFontStyle('B', 11)
    pdf.RDMMultiCell(190, 5, "Download History - #{attachment.filename}")
    pdf.ln
    pdf.RDMMultiCell(190, 5, "##{attachment.container.try(:id)}: #{attachment.container.try(:subject)}")

    page_width    = pdf.get_page_width  # 297
    left_margin   = pdf.get_original_margins['left'] # 10
    right_margin  = pdf.get_original_margins['right'] # 10
    row_height    = 4
    table_width   = page_width - right_margin - left_margin

    pdf.SetFontStyle('B', 8)
    pdf.set_fill_color(230, 230, 230)

    pdf.RDMMultiCell(table_width / 2, row_height, 'Login', 1, '', 1, 0)
    pdf.RDMMultiCell(table_width / 2, row_height, 'Date', 1, '', 1, 0)
    pdf.ln

    pdf.SetFontStyle('', 8)
    pdf.set_fill_color(255, 255, 255)
    histories.each do |history|
      pdf.RDMMultiCell(table_width / 2, row_height, history.user.login, 1, '', 1, 0)
      pdf.RDMMultiCell(table_width / 2, row_height, format_time(history.created_at), 1, '', 1, 0)
      pdf.ln
    end

    pdf.output
  end

end
