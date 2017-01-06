require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.default_facts = {
    :osfamily        => 'RedHat',
    :operatingsystem => 'RedHat',
    :architecture    => 'x86_64',
    :kernel          => 'Linux',
    :operatingsystemrelease => '7.2',
    :consul_version  => '0.6.4',
  }.merge({})
end
