# Linux Install List




## 1. 설치  전 리눅스 세팅


  - 사용 IP : 171(Master), 172(Slave01), 173(Slave02)
  - 우리가 사용할 계정은 'root'가 아닌 'hadoop'계정
  - hadoop계정 내에서 모든 설치를 진행할 예정





## 2. 프로그램 설치

###  1) JDK_1.8.0_171 설치
  
  - Hadoop/Spark 등 우리가 빅데이터를 다루기 위해 가장 기본적으로 필요한 것이 JAVA이다. jar파일을 이용해야 하기 때문이다.
  
  - 모든 Linux서버에 Java설치를 한다.( 하둡의 클러스터링으로 인해 모든 서버에 Java가 필요하다 )
 
  - JDK 설치 경로 : /home/hadoop
     
  - 환경변수 설정 : /home/hadoop/.bashrc 
 
 
````javascript
 
 # Set JAVA_HOME
export JAVA_HOME=$HOME/jdk1.8.0_171
export PATH=$HOME/jdk1.8.0_171/bin:$PATH
export JRE_HOME=$HOME/jdk1.8.0_171/jre
export PATH=$PATH:$HOME/jdk1.8.0_171/jre/bin
export CLASSPATH="."

````
     
     
     
     
 ###  2) Hadoop-2.7.3
 
   - 모든 리눅스 서버에 Hadoop을 설치
   
   - Hadoop이 모든 Slave서버에 인증없이 접근 가능하게 하기 위해 ssh 인증키를 등록해야 한다.
   
  * SSH 인증키 등록(Master)
    * hadoop 계정 접속
    * $ssh-keygen -t rsa
    * 위의 명령으로 생성된 키는 /home/hadoop/.ssh/경로에 있다.
    * id_rsa 는 개인키 / id_rsa.pub 는 공개키 
    
    
    
    
####    (1) Master 서버 : .ssh 디렉터리 설정 
````javascript

  $ ssh-keygen -t rsa
  $ cd ~/.ssh/ 
  $ cp ./id_rsa.pub ./authorized_keys
  $ chmod 755 ~/.ssh
  $ chmod 644 ~/.ssh/autorized_keys
  $ ssh-add
Could not open a connection to your authentication agent.
  $ eval $(ssh-agent)
  $ ssh-add
  

    
  * Slave서버의 권한 변경
    * slave01/slave02의 hadoop 계정 접속
    * master서버가 slave01/slave02의 .ssh에 접근할 수 있도록 권한 설정
    * chmod 755 ~/.ssh
  
  
  * master -> slave01/slave02 ( 인증키  복사 ) 
    * master 접속
    * $ cd ~/.ssh/
    * $ scp ./authorized_keys hadoop@slave01:~/.ssh/  ( 인증키 복사 )
    * $ scp ./authorized_keys hadoop@slave01:~/.ssh/
    * $ ssh hadoop@master date
    * $ ssh hadoop@slave01 date
    * $ ssh hadoop@slave02 date ( 다른 컴퓨터들과 연결하는 작업이다. )
   
````




***



#### (2) hadoop 환경 설정 

##### /home/hadoop/hadoop/etc/hadoop/hadoop-env.sh
````javascript

 export JAVA_HOME=${JAVA_HOME}
 export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"/etc/hadoop"}

````


   - Nadenode : Master서버 / Datanode : Slave서버 설치
   
   -/home/hadoop/hadoop-2.7.3/hdfs/namenode2와 datanode2는 각 Master와 Slave에 만들어준 디렉터리
   

   
***   




#### (3) Master(NameNode설정) : /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml 
##### 데이터 저장 경로 변경
##### hdfs-site.xml 파일은 HDFS에서 사용할 환경 정보를 설정합니다.

````javascript

<configuration>
        <property>
                <name>dfs.replication</name>
                <value>2</value>
        </property>
        <property>
                <name>dfs.permissions</name>
                <value>false</value>
        </property>
        <property>
                <name>dfs.permissions.enabled</name>
                <value>false</value>
        </property>
        <property>
                <name>dfs.permissions.superusergroup</name>
                <value>supergroup</value>
        </property>
        <property>
                <name>dfs.namenode.name.dir</name>
                <value>/home/hadoop/hadoop-2.7.3/hdfs/namenode2</value>
        </property>
</configuration>

````



***




#### (4) Slave (DataNode설정) : /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml 
##### 데이터 저장 경로 변경
##### hdfs-site.xml 파일은 HDFS에서 사용할 환경 정보를 설정합니다.
````javascript

<configuration>
        <property>
                <name>dfs.replication</name>
                <value>2</value>
        </property>
        <property>
                <name>dfs.permissions</name>
                <value>false</value>
        </property>
        <property>
                <name>dfs.permissions.enabled</name>
                <value>false</value>
        </property>
        <property>
                <name>dfs.permissions.superusergroup</name>
                <value>supergroup</value>
        </property>
        <property>
                <name>dfs.datanode.data.dir</name>
                <value>/home/hadoop/hadoop-2.7.3/hdfs/datanode2</value>
        </property>
</configuration>

````




***




#### (5) Yarn 설정 : /home/hadoop/hadoop/etc/hadoop/yarn-site.xml 
##### default설정을 하는게 맞지만 mapred-site.xml에서 yarn을 선택했기 

````javascript

<configuration>          

     <!--Yarn Scheduler를 위한 NodeManager , ResourceManager 설정  -->

        <property>
                <name>yarn.nodemanager.aux-services</name>
                <value>mapreduce_shuffle</value>
        </property>
        <property>  
                <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
                <value>org.apache.hadoop.mapred.ShuffleHandler</value>
        </property>
        <property>
                <name>yarn.resourcemanager.resource-tracker.address</name>
                <value>master:8025</value>
        </property>
        <property>
                <name>yarn.resourcemanager.scheduler.address</name>
                <value>master:8030</value>
        </property>
        <property>
                <name>yarn.resourcemanager.address</name>
                <value>master:8050</value>
        </property>
        
     <!-- Yarn의   최대 용량 할당 및  동적 메모리 할당 차단 -->
       <property>
                <name>yarn.scheduler.maximum-allocation-mb</name>
                <value>40960</value>
        </property>
        <property>
                <name>yarn.nodemanager.pmem-check-enabled</name>
                <value>false</value>
        </property>
        <property>
                <name>yarn.nodemanager.vmem-check-enabled</name>
                <value>false</value>
        </property>
</configuration>

````




***




#### (6) Master서버 지정 : /home/hadoop/hadoop/etc/hadoop/core-site.xml 
#####core-site.xml 파일은 HDFS와 맵리듀스에서 공통적으로 사용할 환경정보 설정
#####로그파일, 네트워크 튜닝, I/O 튜닝, 파일 시스템 튜닝, 압축 등 하부 시스템 설정파일

````javascript

<configuration>
        <property>
                <name>hadoop.tmp.dir</name>
                <value>/home/hadoop/hadoop-2.7.3/tmp</value>
        </property>
        <property>
                <name>fs.default.name</name>
                <value>hdfs://master:9000</value>
                <description>juwon</description>
        </property>
</configuration>

````



***




#### (7) 맵리듀스에서 사용할 환경정보 설정 : /home/hadoop/hadoop/etc/hadoop/mapred-site.xml 


````javascript

<configuration>
        <property>
                <name>mapreduce.framework.name</name>
                <value>yarn</value>
        </property>
        <property>
                <name>mapreduce.jobhistory.address</name>
                <value>master:10020</value>
                <description>Host and Port for Job History Server(default 0.0.0.0:10020) </description>
        </property>
</configuration>

````



#####  2) JDK_1.8.0_171 설치
  
  - Hadoop/Spark 등 우리가 빅데이터를 다루기 위해 가장 기본적으로 필요한 것이 JAVA이다. jar파일을 이용해야 하기 때문이다.
  
  - 모든 Linux서버에 Java설치를 한다.( 하둡의 클러스터링으로 인해 모든 서버에 Java가 필요하다 )
 
  - JDK 설치 경로 : /home/hadoop
     
  - 환경변수 설정 : /home/hadoop/.bashrc 

