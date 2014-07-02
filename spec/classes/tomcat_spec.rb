require 'spec_helper'

describe '::tomcat' do
  context 'default' do
    it 'should install tomcat' do
      should contain_class('java', 'tomcat::install', 'tomcat::config', 'tomcat::service')
    end
  end

  context 'java preinstalled' do
    let(:params){{
      :install_java => false,
    }}

    it 'should not install java' do
      should_not contain_class 'java'
      should contain_class('tomcat::install', 'tomcat::config', 'tomcat::service')
    end
  end
end
