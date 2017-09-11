require 'windows_server_info/checks/check'

require 'hashdiff'

module WindowsServerInfo
  module Checks
    class SharedDirectories < Check
      class << self
        def get(server_auth)
          cmd = 'Get-WmiObject -Class Win32_Share | Select -Expand Name'
          run_powershell(cmd, server_auth).stdout.split(/\r\n/)
        end
      end
    end
  end
end
