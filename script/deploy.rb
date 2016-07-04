#!/usr/bin/env ruby

#
# Deploy Paus cluster to EC2
#
# Usage:
#   script/deploy.rb
#

require 'erb'
require 'open3'
require 'open-uri'
require 'yaml'

begin
  require 'dotenv'
rescue LoadError
  $stderr.puts "Please install dotenv to load .env:"
  $stderr.puts "  $ vagrant plugin install dotenv"
  exit 1
end

num_instances = (ENV["NUM_INSTANCES"] || "4").to_i

# Used to fetch a new discovery token for a cluster of size $num_instances
new_discovery_url="https://discovery.etcd.io/new?size=#{num_instances}"
token = open(new_discovery_url).read

# Create user-data from erb template
Dotenv.load
erb = File.open(File.join(Dir.pwd, "user-data.yml.erb")) { |f| ERB.new(f.read) }

datadog_enabled = ENV["PAUS_DATADOG_ENABLED"] && ["1", "true"].include?(ENV["PAUS_DATADOG_ENABLED"].downcase)

[[:manager, 1], [:replica, num_instances - 1]].each do |instance|
  instance_type, instance_count = *instance

  user_data_path = File.join(Dir.pwd, "user-data-#{instance_type}")
  File.write(user_data_path, erb.result(binding))

  data = YAML.load(IO.readlines(user_data_path)[1..-1].join)
  if data['coreos'].key? 'etcd'
    data['coreos']['etcd']['discovery'] = token
  end
  if data['coreos'].key? 'etcd2'
    data['coreos']['etcd2']['discovery'] = token
  end

  # Fix for YAML.load() converting reboot-strategy from 'off' to `false`
  if data['coreos'].key? 'update'
    if data['coreos']['update'].key? 'reboot-strategy'
      if data['coreos']['update']['reboot-strategy'] == false
        data['coreos']['update']['reboot-strategy'] = 'off'
      end
    end
  end

  yaml = YAML.dump(data)
  File.open(user_data_path, 'w') { |file| file.write("#cloud-config\n\n#{yaml}") }

  ec2c_commands = %W(
    ec2c launch
    --ami #{ENV["AWS_AMI_ID"]}
    --publicip
    --az #{ENV["AWS_AVAILABILITY_ZONE"]}
    --count #{instance_count}
    --type #{ENV["AWS_#{instance_type.upcase}_INSTANCE_TYPE"]}
    --key #{ENV["AWS_SSH_KEY_NAME"]}
    --sg #{ENV["AWS_SECURITY_GROUPS"]}
    --subnet #{ENV["AWS_SUBNET_ID"]}
    --userData #{user_data_path}
    --volumeSize #{ENV["AWS_VOLUME_SIZE"]}
  )

  Open3.popen2(*ec2c_commands) do |_, stdout, wait_thr|
    stdout.each { |line| puts line }

    exit wait_thr.value.exitstatus unless wait_thr.value.success?
  end
end
