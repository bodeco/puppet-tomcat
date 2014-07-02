require 'spec_helper'

describe 'tomcat::resource' do
  context 'default location' do
    let(:pre_condition){ 'include tomcat' }

    let(:title){ 'db1' }
    let(:params){{
      :host     => '192.168.1.1',
      :port     => '1521',
      :service  => 'orcl',
      :username => 'user',
      :password => 'password',
    }}

    it 'should configure connection in context.xml' do

      should contain_datacat_fragment("db1 resource in tomcat context.xml").with({
        :target => "/opt/tomcat/conf/context.xml",
        :data   => {
          'resource' => {
            'jdbc/db1' => {
              'auth'              => 'Container',
              'type'              => 'javax.sql.DataSource',
              'driver_class_name' => 'oracle.jdbc.OracleDriver',
              'url'               => "jdbc:oracle:thin:@192.168.1.1:1521:orcl",
              'username'          => 'user',
              'password'          => 'password',
              'max_active'        => '20',
              'max_idle'          => '10',
              'max_wait'          => '-1',
            },
          },
        }
      })
    end
  end

  context 'custom location' do
    let(:pre_condition){ 'class { "tomcat": path => "/usr/local/tomcat", }' }

    let(:title){ 'db1' }
    let(:params){{
      :full_name         => 'demo',
      :host              => '192.168.1.1',
      :port              => '1521',
      :service           => 'orcl',
      :username          => 'user',
      :password          => 'password',
      :auth              => 'test',
      :type              => 'sql',
      :driver_class_name => 'jdbc',
      :max_active        => '100',
      :max_idle          => '5',
      :max_wait          => '1',
    }}

    it 'should configure connection in context.xml' do
      should contain_datacat_fragment("db1 resource in tomcat context.xml").with({
        :target => "/usr/local/tomcat/conf/context.xml",
        :data   => {
          'resource' => {
            'demo' => {
              'auth'              => 'test',
              'type'              => 'sql',
              'driver_class_name' => 'jdbc',
              'url'               => "jdbc:oracle:thin:@192.168.1.1:1521:orcl",
              'username'          => 'user',
              'password'          => 'password',
              'max_active'        => '100',
              'max_idle'          => '5',
              'max_wait'          => '1',
            },
          },
        }
      })
    end
  end
end
