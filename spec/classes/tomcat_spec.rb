require 'spec_helper'

describe '::tomcat' do
  context 'default' do
    let(:facts){{
      :architecture      => 'x86_64',
      :osfamily          => 'redhat',
      :lsbmajdistrelease => 6,
    }}

    it 'should install tomcat' do
      should contain_class('java', 'tomcat::install', 'tomcat::config', 'tomcat::service')
    end
  end

  context 'java preinstalled' do
    let(:facts){{
      :architecture      => 'x86_64',
      :osfamily          => 'redhat',
      :lsbmajdistrelease => 6,
    }}

    let(:params){{
      :install_java => false,
    }}

    it 'should not install java' do
      should_not contain_class 'java'
      should contain_class('tomcat::install', 'tomcat::config', 'tomcat::service')
    end
  end


  context 'alternate repo' do
    let(:facts){{
      :architecture      => 'i386',
      :osfamily          => 'redhat',
      :lsbmajdistrelease => 5,
    }}


    let(:params){{
      :source => @undef,
    }}

    it do
    end
  end
end
