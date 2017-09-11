require 'ostruct'
require 'timeout'
require 'winrm'

module WindowsServerInfo
  module Checks
    class Check
      class << self
        def run_powershell(command, server_auth)
          server_auth = {
            host: '127.0.0.1',
            user: 'vagrant',
            password: 'vagrant'
          } if server_auth[:host] == 'kitchen'

          server_auth[:endpoint] = "http://#{server_auth[:host]}:5985/wsman"

          Timeout.timeout(10) do
            WinRM::Connection.new(server_auth).shell(:powershell) { |shell| shell.run(command) }
          end
        rescue Timeout::Error
          OpenStruct.new(stdout: '', stderr: 'WinRM execution timed out', exitcode: 1)
        end

        def diff(server_auth_1, server_auth_2)
          HashDiff.diff(get(server_auth_1), get(server_auth_2))
        end
      end
    end
  end
end