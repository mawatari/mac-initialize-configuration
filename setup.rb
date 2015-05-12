require 'yaml'
require 'shellwords'

def initialize_configuration (application)
  while true
    print "#{application["name"]}の設定ファイルを上書きし初期化します。 [y|n]: "
    response = gets
    case response
      when /^[yY]/
        print "\e[31m"
        `mkdir -p #{application["path"].sub(/^~/, Dir.home).shellescape}`
        `cp #{Dir.getwd}/configurations/#{application["name"].shellescape}/#{application["file"].shellescape} #{application["path"].sub(/^~/, Dir.home).shellescape}`
        print "\e[0m"
        puts "\e[32m完了しました。\e[0m" if $?.success?
        return true
      else
        puts "\e[36m取り消しました。\e[0m"
        return false
    end
  end
end

applications = YAML.load_file('applications.yml')

applications.each do |application|
  initialize_configuration application
end
