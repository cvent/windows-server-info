require 'hashdiff'
require 'ostruct'
require 'net/ping'
require 'timeout'
require 'winrm'

module WindowsServerInfo
  module Checks
    class Check
      class << self
        def localhost
          if Net::Ping::External.new('docker.for.mac.localhost').ping?
            'docker.for.mac.localhost'
          else
            '127.0.0.1'
          end
        end

        def run_powershell(command, server_auth)
          server_auth = {
            host: localhost,
            user: 'vagrant',
            password: 'vagrant'
          } if server_auth[:host] == 'kitchen'

          server_auth[:endpoint] = "http://#{server_auth[:host]}:5985/wsman"

          Timeout.timeout(30) do
            WinRM::Connection.new(server_auth).shell(:powershell) { |shell| shell.run(command) }
          end
        rescue Timeout::Error
          OpenStruct.new(stdout: '', stderr: 'WinRM execution timed out', exitcode: 1)
        end

        def diff(server_auth_1, server_auth_2)
          HashDiff.diff(get(server_auth_1), get(server_auth_2))
        end

        def to_s
          name.split('::').last
        end
      end
    end
  end
end
