require 'spec_helper'

describe 'tomcat::war' do
  context 'default location' do
    let(:pre_condition){ 'include tomcat' }

    let(:title){ 'demo.war' }
    let(:params){{
      :source => 'puppet:///modules/tomcat/demo.war',
    }}

    it 'should deploy war in webapps' do
      should contain_file('/opt/tomcat/webapps/demo.war').with({
        :owner   => 'tomcat',
        :group   => 'tomcat',
        :mode    => '0644',
        :source  => 'puppet:///modules/tomcat/demo.war',
      })
    end
  end

  context 'custom location' do
    let(:pre_condition){ 'class { "tomcat": path => "/usr/local/tomcat", user => "root", group => "root", }' }

    let(:title){ 'demo.war' }
    let(:params){{
      :source => 'puppet:///modules/tomcat/demo.war',
    }}

    it 'should deploy war in webapps' do
      should contain_file('/usr/local/tomcat/webapps/demo.war').with({
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0644',
        :source  => 'puppet:///modules/tomcat/demo.war',
      })
    end
  end
end
