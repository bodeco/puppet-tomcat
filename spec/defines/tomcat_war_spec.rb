require 'spec_helper'

describe 'tomcat::lib' do
  context 'default location' do
    let(:pre_condition){ 'include tomcat' }

    let(:title){ 'jta.jar' }
    let(:params){{
      :source => 'puppet:///modules/tomcat/jta.jar',
    }}

    it 'should deploy file in lib' do
      should contain_file('/opt/tomcat/lib/jta.jar').with({
        :owner   => 'tomcat',
        :group   => 'tomcat',
        :mode    => '0644',
        :source  => 'puppet:///modules/tomcat/jta.jar',
        :content => nil,
      })
    end
  end

  context 'custom location' do
    let(:pre_condition){ 'class { "tomcat": path => "/usr/local/tomcat", user => "root", group => "root", }' }

    let(:title){ 'jta.jar' }
    let(:params){{
      :mode    => '0755',
      :content => 'hello',
    }}

    it 'should deploy file in lib' do
      should contain_file('/usr/local/tomcat/lib/jta.jar').with({
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0755',
        :source  => nil,
        :content => 'hello',
      })
    end
  end
end
