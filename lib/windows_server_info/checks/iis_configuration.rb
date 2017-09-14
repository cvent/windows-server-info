require 'windows_server_info/checks/check'

require 'nori'

module WindowsServerInfo
  module Checks
    class IISConfiguration < Check
      class << self
        def get(server_auth)
          cmd = 'cat /windows/system32/inetsrv/config/applicationHost.config'
          Nori.new(parser: :rexml).parse(run_powershell(cmd, server_auth).stdout)
        end

        def to_s
          'IIS Configuration'
        end
      end
    end
  end
end
