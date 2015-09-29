module RemineDownloadHistory
  module AttachmentsControllerPatch
    def self.included(base)
      base.class_eval do

        def download_with_plugin
          DownloadHistory.create(attachment_id: @attachment.id, user_id: User.current.id)
          download_without_plugin
        end
        alias_method_chain :download, :plugin

      end
    end
  end

end
