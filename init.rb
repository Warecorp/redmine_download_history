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
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  project_module :issue_tracking do |map|
    map.permission :view_attachment_history, { }
  end

end
