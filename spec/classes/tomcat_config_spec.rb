require 'spec_helper'

describe 'tomcat' do
  context 'default install' do
    it 'should config tomcat' do
      should contain_class('tomcat::config')
      should contain_datacat('/opt/tomcat/conf/context.xml')
      should contain_datacat_fragment('use_http_only in tomcat context.xml').
        with_data({'use_http_only'=>false})
    end
  end

  context 'custom install' do
    let(:params){{
      :path          => '/usr/local/tomcat',
      :use_http_only => true,
    }}

    it 'should config tomcat' do
      should contain_class('tomcat::config')
      should contain_datacat('/usr/local/tomcat/conf/context.xml')
      should contain_datacat_fragment('use_http_only in tomcat context.xml').
        with_data({'use_http_only'=>true})
    end
  end
end
