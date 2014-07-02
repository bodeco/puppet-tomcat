require 'spec_helper'

describe 'tomcat' do
  context 'default install' do
    let(:facts){{
      :architecture      => 'x86_64',
      :osfamily          => 'redhat',
      :lsbmajdistrelease => 6,
    }}

    it 'should install tomcat' do
      should contain_class('tomcat::install')
      should contain_package('unzip', 'redhat-lsb-core')

      should contain_user('tomcat')
      should contain_group('tomcat')
      should contain_staging__file('apache-tomcat-6.0.41.tar.gz')
      should contain_file('/opt/tomcat').with({
        :owner => 'tomcat',
        :group => 'tomcat',
      })

      should contain_exec('tomcat owner').
        with_command('chown -R tomcat:tomcat /opt/apache-tomcat-6.0.41')
    end
  end

  context 'custom install' do
    let(:facts){{
      :architecture      => 'x86_64',
      :osfamily          => 'redhat',
      :lsbmajdistrelease => 6,
    }}

    let(:params){{
      :version => '6.0.42',
      :path    => '/usr/local/tomcat',
      :user    => 'root',
      :group   => 'root',
    }}

    it 'should install tomcat' do
      should contain_class('tomcat::install')
      should contain_package('unzip', 'redhat-lsb-core')

      should contain_user('root')
      should contain_group('root')
      should contain_staging__file('apache-tomcat-6.0.42.tar.gz')
      should contain_file('/usr/local/tomcat').with({
        :owner => 'root',
        :group => 'root',
      })

      should contain_exec('tomcat owner').
        with_command('chown -R root:root /opt/apache-tomcat-6.0.42')
    end
  end
end
