require 'windows_server_info/checks/check'

module WindowsServerInfo
  module Checks
    class ScheduledTasks < Check
      class << self
        def get(server_auth)
          cmd = 'ls -Path /windows/system32/tasks |? { $_.GetType().Name -eq "FileInfo" } | Select -Expand Name'
          run_powershell(cmd, server_auth).stdout.split(/\r\n/)
        end

        def to_s
          'Scheduled Tasks'
        end
      end
    end
  end
end
