require 'windows_server_info/checks/check'

module WindowsServerInfo
  module Checks
    class Features < Check
      class << self
        def get(server_auth)
          cmd = 'Import-Module ServerManager; Get-WindowsFeature |? {$_.Installed } | Select -Expand Name'
          run_powershell(cmd, server_auth).stdout.split(/\r\n/)
        end
      end
    end
  end
end
