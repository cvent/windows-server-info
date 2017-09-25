require 'windows_server_info/checks'

require 'colorize'
require 'thor'

module WindowsServerInfo
  class Cli < Thor
    class_option :username, type: :string, required: true
    class_option :password, type: :string, required: true

    no_commands do
      @@config_types = [
        Checks::ScheduledTasks,
        Checks::NetworkMounts,
        Checks::IISConfiguration,
        Checks::Services,
        Checks::Features,
        Checks::SharedDirectories,
        Checks::Applications,
        Checks::Processes,
        Checks::DotNetFrameworkVersions
      ]

      def server_info(server, options = {})
        server_auth = {
          host: server,
          user: options[:username],
          password: options[:password]
        }

        @@config_types.each do |type|
          puts " #{type} ".center(30, '=').blue
          p type.get(server_auth)
          puts
        end
      end

      def server_diff(server1, server2, options = {})
        server_auth_1 = {
          host: server1,
          user: options[:username],
          password: options[:password]
        }

        server_auth_2 = {
          host: server2,
          user: options[:other_username] ? options[:other_username] : options[:username],
          password: options[:other_password] ? options[:other_password] : options[:password]
        }

        @@config_types.each do |type|
          puts " #{type} ".center(30, '=').blue
          type.diff(server_auth_1, server_auth_2).each do |e|
            puts "#{e[0]} #{e[1]} (#{e[2]})"
          end
          puts
        end
      end
    end

    desc 'info SERVER1 [SERVER2]', 'Information about SERVER (and optionally compare against SERVER2)'
    option :other_username
    option :other_password
    def info(server1, server2 = nil)
      if server2
        puts "#{server1} <=> #{server2}".bold
        server_diff(server1, server2, options)
      else
        puts server1.bold
        server_info(server1, options)
      end
    end

    disable_required_check! :kitchen

    desc 'kitchen', 'get information on a kitchen VM'
    def kitchen
      info('kitchen')
    end
  end
end
