require 'windows_server_info/checks/check'

require 'hashdiff'

module WindowsServerInfo
  module Checks
    class Services < Check
      class << self
        def get(server_auth)
          cmd = 'Get-Service | Select -Expand Name'
          run_powershell(cmd, server_auth).stdout.split(/\r\n/)
        end
      end
    end
  end
end
