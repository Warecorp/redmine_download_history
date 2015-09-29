require 'redmine'
require 'dispatcher'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'attachments_controller_patch'
  require_dependency 'issue'

  AttachmentsController.send(:include, RemineDownloadHistory::AttachmentsControllerPatch)
end

Redmine::Plugin.register :redmine_download_history do
  name 'Redmine Download History plugin'
  author 'Alex Klimenkov'
  description 'This is a plugin for Redmine for save history after each download attachment'
  version '0.0.1'
  url 'https://github.com/Warecorp/redmine_download_history'
  author_url 'https://github.com/AlexKlim'

  project_module :issue_tracking do |map|
    map.permission :view_attachment_history, { }
  end

end
