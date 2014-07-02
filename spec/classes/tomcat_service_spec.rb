require 'spec_helper'

describe 'tomcat' do
  context 'default install' do
    it 'should config tomcat service' do
      should contain_class('tomcat::service')
      should contain_file('/etc/init.d/tomcat').
        with_content(/-Xms1536m -Xmx1536m -XX:MaxPermSize=256m -Djava.awt.headless=true/)
      should contain_service('tomcat')
    end
  end

  context 'custom install' do
    let(:params){{
      :java_xms => '2048m',
      :java_xmx => '2048m',
      :java_max_perm_size => '512m',
      :java_options => '-Djava.awt.headless=false',
    }}

    it 'should config tomcat service' do
      should contain_class('tomcat::service')
      should contain_file('/etc/init.d/tomcat').
        with_content(/-Xms2048m -Xmx2048m -XX:MaxPermSize=512m -Djava.awt.headless=false/)
      should contain_service('tomcat')
    end
  end
end
