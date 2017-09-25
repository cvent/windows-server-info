require 'windows_server_info/checks/check'

module WindowsServerInfo
  module Checks
    class DotNetFrameworkVersions < Check
      class << self
        def get_dotnet_2_version(server_auth)
          cmd = 'Get-ChildItem "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP" -Recurse | Get-ItemProperty -name Version,Release -EA 0 | Where { $_.PSChildName -match "^v2." } | Select -Expand Version'
          run_powershell(cmd, server_auth).stdout.split(/\r\n/)
        end

        def get_dotnet_3_version(server_auth)
          cmd = 'Get-ChildItem "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP" -Recurse | Get-ItemProperty -name Version,Release -EA 0 | Where { $_.PSChildName -match "^v3." } | Select -Expand Version'
          run_powershell(cmd, server_auth).stdout.split(/\r\n/)
        end

        def get_dotnet_4_version(server_auth)
          cmd = 'Get-ChildItem "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP" -Recurse | Get-ItemProperty -name Version,Release -EA 0 | Where { $_.Version -match "^4." -and $_.Release } | Select -Expand Release'
          v4_versions = run_powershell(cmd, server_auth).stdout.split(/\r\n/).uniq

          v4_versions.map { |release| release.to_i }.map do |release|
            case release
            when 378389 then "4.5"
            when 378675, 378758 then "4.5.1"
            when 379893 then "4.5.2"
            when 393295, 393297 then "4.6"
            when 394254, 394271 then "4.6.1"
            when 394802, 394806 then "4.6.2"
            when 460798 then "4.7"
            else "Undocumented v4 version (#{release})"
            end
          end
        end

        def get(server_auth)
          get_dotnet_2_version(server_auth) + get_dotnet_3_version(server_auth) + get_dotnet_4_version(server_auth)
        end

        def to_s
          '.NET Framework Versions'
        end
      end
    end
  end
end
