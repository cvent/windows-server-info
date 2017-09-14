require 'windows_server_info/checks/check'

module WindowsServerInfo
  module Checks
    class NetworkMounts < Check
      class << self
        def get(server_auth)
          cmd = 'Get-CimInstance -Class Win32_NetworkConnection | Select -Expand RemoteName'
          run_powershell(cmd, server_auth).stdout.split(/\r\n/)
        end

        def to_s
          'Network Mounts'
        end
      end
    end
  end
end
