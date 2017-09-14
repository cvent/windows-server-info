require 'windows_server_info/checks/check'

module WindowsServerInfo
  module Checks
    class Processes < Check
      class << self
        def get(server_auth)
          cmd = 'Get-Process | Select -Expand Name'
          run_powershell(cmd, server_auth).stdout.split(/\r\n/)
        end
      end
    end
  end
end
