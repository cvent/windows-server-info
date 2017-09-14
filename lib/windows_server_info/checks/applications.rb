require 'windows_server_info/checks/check'

module WindowsServerInfo
  module Checks
    class Applications < Check
      class << self
        def get(server_auth)
          cmd = 'Get-WmiObject -Class Win32_Product | Select -Expand Name'
          run_powershell(cmd, server_auth).stdout.split(/\r\n/)
        end
      end
    end
  end
end
